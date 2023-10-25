import ballerina/io;
import ballerina/graphql

public function main() returns error? {
    graphql:Client graphqlClient = check new ("localhost:2120/graphql");
   //data mutations
   var approveResponse = graphqlClient->execute(string`
   mutation{
    approveResponse()
   }

   `,{},"approveResponse",{},[]);
   io:println(approveResponse);


    var scoreKPIResponse = graphqlClient->execute(string`
   mutation{
    scoreKPIResponse()
   }

   `,{},"scoreKPIResponse",{},[]);
   io:println(scoreKPIResponse);

   var scoreSupervisorResponse = graphqlClient->execute(string`
   mutation{
    scoreSupervisorResponse()
   }

   `,{},"scoreSupervisorResponse",{},[]);
   io:println(scoreKPIResponse);




}
