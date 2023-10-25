import ballerina/io;
import ballerina/graphql;

public function main() returns error? {
    graphql:Client graphqlClient = check new ("localhost:2120/graphql");
   //data mutations
   var approveResponse = graphqlClient->execute(string`
   mutation{
	aproveKPI(staff: "202236", ap: "yes")
}
   `,{},"approveResponse",{},[]);
   io:println(approveResponse);


    var scoreKPIResponse = graphqlClient->execute(string`
   mutation{
	scoreKPI(staff: "202236", score: 55)
}

   `,{},"scoreKPIResponse",{},[]);
   io:println(scoreKPIResponse);

   
var scoreSupResp = graphqlClient->execute(string`
mutation{
  scoreSupervisor(staff:"202236", score: 45)
}

   `,{},"scoreSupResp",{},[]);
   io:println(scoreSupResp);



}
