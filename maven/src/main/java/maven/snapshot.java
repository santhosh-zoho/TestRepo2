package maven;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpHost;
import org.elasticsearch.action.admin.cluster.snapshots.create.CreateSnapshotRequest;
import org.elasticsearch.action.admin.cluster.snapshots.create.CreateSnapshotResponse;
import org.elasticsearch.action.admin.cluster.snapshots.delete.DeleteSnapshotRequest;
import org.elasticsearch.action.admin.cluster.snapshots.get.GetSnapshotsRequest;
import org.elasticsearch.action.admin.cluster.snapshots.get.GetSnapshotsResponse;
import org.elasticsearch.action.support.master.AcknowledgedResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.rest.RestStatus;
import org.elasticsearch.snapshots.SnapshotId;
import org.elasticsearch.snapshots.SnapshotInfo;


@WebServlet("/snapshot")
public class snapshot extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	public static boolean DeleteSnapshot=false;
	public static RestHighLevelClient client = new RestHighLevelClient(RestClient.builder(new HttpHost("localhost", 9200, "http")));
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String DeleteSnapshotName=request.getParameter("DeleteSnapshot");
		if(DeleteSnapshotName!=null && DeleteSnapshot==false)
			DeleteSnapshot(DeleteSnapshotName,request,response);
		else 
		{
		String Repository="EsBackup";
		GetSnapshotsRequest GetSnapshotrequest = new GetSnapshotsRequest();
		GetSnapshotrequest.repository(Repository);
		GetSnapshotrequest.masterNodeTimeout("1m"); 
		GetSnapshotrequest.ignoreUnavailable(false); 
		GetSnapshotsResponse GetSnapshotresponse = client.snapshot().get(GetSnapshotrequest, RequestOptions.DEFAULT);
		List<SnapshotInfo> snapshotsInfos = GetSnapshotresponse.getSnapshots();
		int length=snapshotsInfos.size(),i=0;
		List<String> startTime=new ArrayList<String>();
		List<String> snapshotId =new ArrayList<String>();
		//List<String> State=new ArrayList<String>();
		int indices[]=new int[length];
		SnapshotInfo snapshotInfo=null;
		DateFormat Dateobj = new SimpleDateFormat("dd MMM yyyy HH:mm:ss");   
		while(i<length) 
		{
		 snapshotInfo = snapshotsInfos.get(i);
		 snapshotId.add(snapshotInfo.snapshotId().toString());
		 Date res = new Date(snapshotInfo.startTime()); 
		 startTime.add(Dateobj.format(res));
		 //State.add(snapshotInfo.state().toString());
		 indices[i] = (snapshotInfo.indices()).size();
		 ++i;
		}
		for(int index=0;index<snapshotId.size();++index)
		{
			String target=snapshotId.get(index).substring(snapshotId.get(index).indexOf("/"));
			snapshotId.set(index,snapshotId.get(index).replace(target,""));
		}
		request.setAttribute("SnapshotName",snapshotId);
		request.setAttribute("Time",startTime);
		request.setAttribute("Indices",indices);
		request.setAttribute("Repository","EsBackup");
		RequestDispatcher rd = request.getRequestDispatcher("SnapShotInfo.jsp");
		rd.forward(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(true);
		String SnapshotName=request.getParameter("SnapshotName");
	    //String SnapshotName="<"+request.getParameter("SnapshotName")+"-{now{yyyy-MM-dd_HH-mm-ss}}>";
		CreateSnapshotRequest SnapshotRequest = new CreateSnapshotRequest();
		SnapshotRequest.snapshot(SnapshotName);
		SnapshotRequest.repository("EsBackup");
		SnapshotRequest.indices("sampleindex");
		SnapshotRequest.partial(false);
		SnapshotRequest.includeGlobalState(false); 
		SnapshotRequest.masterNodeTimeout("1m");
		try 
		{
		 CreateSnapshotResponse Snapshotresponse = client.snapshot().create(SnapshotRequest, RequestOptions.DEFAULT);
		 RestStatus status = Snapshotresponse.status();
		 if(status.toString().equals("ACCEPTED")) 
		 {
				session.setAttribute("snapshot","True");
				session.setAttribute("snapshotName",SnapshotName);
		 }
		 else
		  session.setAttribute("snapshot","Error");
		}
		catch(Exception e) {
			session.setAttribute("snapshot","Error");
			System.out.println(e);
		}
		response.sendRedirect("FileUploadPage.jsp");
	}	
	public void DeleteSnapshot(String SnapshotName,HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		HttpSession session=request.getSession(true);
		boolean Result=false;
		DeleteSnapshotRequest DeleteRequest = new DeleteSnapshotRequest("EsBackup");
		DeleteRequest.snapshots(SnapshotName);
		try {
			AcknowledgedResponse DeleteResponse = client.snapshot().delete(DeleteRequest, RequestOptions.DEFAULT);
			Result = DeleteResponse.isAcknowledged();
		}
		catch(Exception e) 
		{
			System.out.println(e);
			session.setAttribute("snapshotDelete","False");
		}
		
		if(Result) 
			session.setAttribute("snapshotDelete","True");
		else
			session.setAttribute("snapshotDelete","False");
		session.setAttribute("DeleteSnapshotName",SnapshotName);
		DeleteSnapshot=true;
		doGet(request,response);
	}
}
