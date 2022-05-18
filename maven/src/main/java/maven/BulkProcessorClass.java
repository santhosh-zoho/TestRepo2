package maven;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.http.HttpHost;
import org.elasticsearch.action.DocWriteResponse;
import org.elasticsearch.action.bulk.BulkItemResponse;
import org.elasticsearch.action.bulk.BulkProcessor;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;


public class BulkProcessorClass {
	
	static  RestHighLevelClient client = new RestHighLevelClient(RestClient.builder(new HttpHost("localhost", 9200, "http")));
		
	@SuppressWarnings("unchecked")
	public  List<String> BulkProcessorUpload(String [] Data) throws InterruptedException
	{ 
		
		List<String> IdList=new ArrayList<String>();
		BulkProcessor.Listener Listener = new BulkProcessor.Listener() {
		    @Override
		    public void beforeBulk(long executionId, BulkRequest request) 
		    {
		        int numberOfActions = request.numberOfActions();
		    }

		    @Override
		    public void afterBulk(long executionId, BulkRequest request,BulkResponse response)
		    {
		    	for (BulkItemResponse bulkItemResponse : response) 
		    	{ 
				  DocWriteResponse itemResponse = bulkItemResponse.getResponse(); 
                  switch (bulkItemResponse.getOpType()) 
				  {
				    case INDEX:    
				    	IndexResponse indexResponse = (IndexResponse) itemResponse;
				    	 IdList.add(indexResponse.getId()); 
				        break;
					default:
						break;
				  } 
				} 
		    }

		    @Override
		    public void afterBulk(long executionId, BulkRequest request,Throwable failure) 
		    {
		    	System.out.println("ERROR : "+failure);
		       
		    }
		};
		
		//int Id=1;
		//String id="";
		BulkProcessor bulkProcessor = BulkProcessor.builder((request, bulkListener) ->
		                              client.bulkAsync(request, RequestOptions.DEFAULT, bulkListener),Listener).build(); 
		 
	/*	BulkProcessor.Builder builder = BulkProcessor.builder((request, bulkListener) ->
		                               client.bulkAsync(request, RequestOptions.DEFAULT,bulkListener),Listener);
		builder.setBulkActions(50000); */
		 MappingClass MapFun=new MappingClass();
		 Map<String, Object> MapData = new LinkedHashMap<String, Object>();
		 
		 for(String data : Data) {
			 MapData=MapFun.Mapping(data);
			 //id=String.valueOf(Id);
		     bulkProcessor.add(new IndexRequest("sampleindex").source(MapData, XContentType.JSON));
		   // ++Id;	
		 }
		 boolean terminated = bulkProcessor.awaitClose(30L, TimeUnit.SECONDS);
		 System.out.println("Status : "+terminated);
		 bulkProcessor.close();
		return IdList;
		
	}

}
