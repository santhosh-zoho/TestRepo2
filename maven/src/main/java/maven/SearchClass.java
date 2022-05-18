package maven;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpHost;
import org.apache.lucene.search.TotalHits;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;

@WebServlet(name = "searchClass", urlPatterns = { "/searchClass" })

public class SearchClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static RestHighLevelClient client = new RestHighLevelClient(RestClient.builder(new HttpHost("localhost", 9200, "http")));
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		//PrintWriter out = response.getWriter();
		String SearchData = request.getParameter("search");
		String SearchMethod = request.getParameter("SearchMethods");
		//out.println(SearchMethod);
		
		String LCSearchData=SearchData.toLowerCase();
        String UCSearchData=SearchData.toUpperCase();
        String Fields[]={"Name","Working company","Team","Mobile No","dept"};
        SearchRequest searchRequest = new SearchRequest();
		searchRequest.indices("sampleindex");
		
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();        
        BoolQueryBuilder boolQueryBuilder = QueryBuilders.boolQuery(); 
        
        if(SearchMethod.equals("contained"))
        {
         for(String Field : Fields) {
             boolQueryBuilder.should(QueryBuilders.wildcardQuery(Field,"*"+LCSearchData+"*"));
        	 boolQueryBuilder.should(QueryBuilders.matchPhrasePrefixQuery(Field,"*"+LCSearchData+"*"));
         }
         for(String Field : Fields) {
             boolQueryBuilder.should(QueryBuilders.wildcardQuery(Field,"*"+UCSearchData+"*"));
            boolQueryBuilder.should(QueryBuilders.matchPhrasePrefixQuery(Field,"*"+UCSearchData+"*"));
            }
         }
         
         else if(SearchMethod.equals("Exactly"))
         {
          for(String Field : Fields)
          boolQueryBuilder.should(QueryBuilders.wildcardQuery(Field,SearchData));
         }
         
         else if(SearchMethod.equals("Starts with"))
         {
         for(String Field : Fields)
          boolQueryBuilder.should(QueryBuilders.wildcardQuery(Field,SearchData+"*"));	
         }

         
         else if(SearchMethod.equals("Ends with"))
         {
          for(String Field : Fields)
           boolQueryBuilder.should(QueryBuilders.wildcardQuery(Field,"*"+SearchData));
         }
         
         
        
        
        searchSourceBuilder.query(boolQueryBuilder);
        searchSourceBuilder.size(10000);
        searchRequest.source(searchSourceBuilder);

		/*MultiMatchQueryBuilder multiMatchQueryBuilder = QueryBuilders.multiMatchQuery(SearchData+".*", "*");
		//MatchQueryBuilder matchQueryBuilder = new MatchQueryBuilder("*", SearchData);
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		searchSourceBuilder.query(multiMatchQueryBuilder);  */
		searchRequest.source(searchSourceBuilder);
		SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
		SearchHits hits = searchResponse.getHits();
		
		SearchHit[] searchHits = hits.getHits();
		ArrayList<String> DocId = new ArrayList<String>();
		for (SearchHit hit : searchHits) {
			DocId.add(hit.getId());
		}
	//	request.setAttribute("IdList",DocId);
	//	request.setAttribute("SearchedData",SearchData);
		
		HttpSession session = request.getSession();
	    session.setAttribute("SearchMethods",SearchMethod);
	    session.setAttribute("SearchedData",SearchData);
	    session.setAttribute("IdList",DocId);
		
		getServletConfig().getServletContext().getRequestDispatcher("/ShowSearchedData.jsp").forward(request,response);
		
	}
}
