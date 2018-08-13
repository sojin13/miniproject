package crawler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
 
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.HttpClientBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
 
public class CrawlerExample {
 
  public static void main(String[] args) throws ClientProtocolException, IOException {
 
    HttpPost http = new HttpPost("https://");
 
    HttpClient httpClient = HttpClientBuilder.create().build();
 
     
 
    HttpResponse response = httpClient.execute(http);
 
    HttpEntity entity = response.getEntity();
 
    ContentType contentType = ContentType.getOrDefault(entity);
 
    Charset charset = contentType.getCharset();
 
    BufferedReader br = new BufferedReader(new InputStreamReader(entity.getContent(), charset));
 
    StringBuffer sb = new StringBuffer();
 
    String line = "";
 
    while ((line = br.readLine()) != null) {
 
      sb.append(line + "\n");
 
    }
 
    System.out.println(sb.toString());
 
    Document doc = Jsoup.parse(sb.toString());
 
    Document doc2 = Jsoup.connect("https://").get();
     
  }
}