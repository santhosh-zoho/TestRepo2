package maven;


import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.elasticsearch.action.DocWriteResponse;
import org.elasticsearch.action.bulk.BulkItemResponse;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.common.xcontent.XContentType;

public class BulkUpload {
	static  RestHighLevelClient client = new RestHighLevelClient(RestClient.builder(new HttpHost("localhost", 9200, "http")));
	@SuppressWarnings("unchecked")
	public List<String> Upload(String [] Data) throws IOException {
		 
		 BulkRequest Bulkrequest = new BulkRequest("sampleindex"); 
		 List<String> IdList=new ArrayList<String>();
		 int Id=1;
		 int count=0;
		 int noOfBatch=1;
		 String id="1";
		 Map<String, Object> MapData = new LinkedHashMap<String, Object>();
		 MappingClass MapFun=new MappingClass();
		 long starttime = System.nanoTime();
		 
		 for(String data : Data) {
		   id=String.valueOf(Id);
		   MapData=MapFun.Mapping(data);
		   Bulkrequest.add(new IndexRequest().id(id).source(MapData, XContentType.JSON));
		   // request.add(new IndexRequest().id(id).source(new ObjectMapper().writeValueAsString(Pojo), XContentType.JSON));
		   ++count;
		   ++Id;
		   if(count==10000)
		   {
			   IdList.addAll(addDocumentToElasticsearch(Bulkrequest,noOfBatch,count));
			   Bulkrequest = new BulkRequest("sampleindex");
			   ++noOfBatch;
			   count=0;
		   }
		 } 
		 
		 if(count!=0) 
		 {
		   IdList.addAll(addDocumentToElasticsearch(Bulkrequest,noOfBatch,count));
		   ++noOfBatch;
		 }
		  long endtime   = System.nanoTime();
		  long totalTime = endtime - starttime;

		System.out.println("Total time for bulkResponse       : "+totalTime);
		
		return IdList;
	}
	
	
	 public List<String> addDocumentToElasticsearch(BulkRequest Bulkrequest,int noOfBatch,int count) throws IOException
	 {
		
			
		 
         List<String> IdList=new ArrayList<String>();
		 Bulkrequest= Bulkrequest.timeout(TimeValue.timeValueMinutes(2));   
		 System.out.println("Sending request of batch no "+noOfBatch);
		 BulkResponse bulkResponse = client.bulk(Bulkrequest, RequestOptions.DEFAULT);
		 
		 // checking if any file upload failed
		 if (bulkResponse.hasFailures()) 
		 { 
	         System.out.println("one or more operation has failed in batch "+noOfBatch);
	         for (BulkItemResponse bulkItemResponse : bulkResponse) 
	         {
	       	    if (bulkItemResponse.isFailed()) 
	       	    { 
	       	        BulkItemResponse.Failure failure=bulkItemResponse.getFailure(); 
	       	        System.out.print(failure.getId()+" : ");
	       	        System.out.println(failure.getCause());
	       	        
	       	    }
	       	}
		 }
		 else 
	    	System.out.println(" All File's( "+count+" )inserted suucesfully int this Batch : "+noOfBatch);
		 
		 // getting index id's from bulkResponse
		 for (BulkItemResponse bulkItemResponse : bulkResponse) { 
			    DocWriteResponse itemResponse = bulkItemResponse.getResponse(); 

			    switch (bulkItemResponse.getOpType()) 
			    {
			    case INDEX:    
			    	IndexResponse indexResponse = (IndexResponse) itemResponse;
			    	 IdList.add(indexResponse.getId());  
			    	 //System.out.println("File inserted Responce Id : "+indexResponse.getId());
			        break;
				default:
					break;
			    }
			    
			}
	    System.out.println("No of Id's : "+IdList.size());
		return IdList;
		 
	 }
	
}

