import ballerina/graphql;
import ballerina/io;

public function main() returns error? {

  graphql:ClientConfig config = {
    url: "http://localhost:2120/performanceSystem"
  };

  graphql:Client client = check new (config);

  // Query all employees supervised by a given name
  string query = string `query getAllEmployees($name: String!) {
    AllSupervised(name: $name) {
      staffID
      Name
      Department
      Position
    }
  }`;
  
  json variables = {"name": "John Doe"};
  json result = check client->query(query, variables);
  io:println(result);

  // Mutation to approve a KPI
  string approveMutation = string `mutation approveKPI($id: ID!, $approved: Boolean!) {
    aproveKPI(staff: $id, ap: $approved) 
  }`;

  json approveVars = {"id": "E001", "approved": true};
  json approveResult = check client->mutate(approveMutation, approveVars);
  io:println(approveResult);

  // Mutation to score a KPI
  string scoreMutation = string `mutation scoreKPI($id: ID!, $score: Int!) {
    scoreKPI(staff: $id, score: $score)
  }`;

  json scoreVars = {"id": "E001", "score": 4};
  json scoreResult = check client->mutate(scoreMutation, scoreVars);
  io:println(scoreResult);

}
