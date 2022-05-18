package maven;

import java.io.IOException;
import org.apache.http.HttpHost;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
//import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;

public class GetDataById {

	
	
	/*
	 * public static void main(String[] args) throws IOException { GetDataById
	 * dataGet=new GetDataById();
	 * System.out.println(dataGet.GetData("14BjbX8BHJrlcHbny7SI")); }
	 */
	 
	 
 public String GetData(String Id) throws IOException {
	 
		RestHighLevelClient client = new RestHighLevelClient(RestClient.builder(new HttpHost("localhost", 9200, "http")));
	/*
	    GetSourceRequest getSourceRequest = new GetSourceRequest("sampleindex",Id);
		//SearchRequest searchRequest = new SearchRequest("sampleindex");
		GetSourceResponse response =client.getSource(getSourceRequest, RequestOptions.DEFAULT);
	*/	
		SearchRequest searchRequest = new SearchRequest();
		searchRequest.indices("sampleindex");
		MatchQueryBuilder matchQueryBuilder = new MatchQueryBuilder("_id",Id);
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		searchSourceBuilder.query(matchQueryBuilder);
		searchRequest.source(searchSourceBuilder);
		SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
		SearchHits hits = searchResponse.getHits();
		SearchHit[] searchHits = hits.getHits();
		String sourceAsString=null;
		for (SearchHit hit : searchHits) {
			sourceAsString = hit.getSourceAsString();
		}
	    return sourceAsString;
	 
 }
}