import ballerina/graphql;
import ballerinax/mongodb;

type Employee record  {
      string staffID;
      string Name;
      string Department;
      string Position;
      string KPI;
      string Aprove;
      string KPIscore;
      string Supervisor;
    };



mongodb:ConnectionConfig mongoConfig = {
connection: {
host: "localhost",
port: 27017,
auth: {
username: "",
password: ""
},
options: {sslEnabled: false, serverSelectionTimeout: 5000}
},
databaseName:"performanceDB"
};

isolated mongodb:Client dbClient = check new (mongoConfig);
configurable string userCollection = "users";
configurable string departmentCollection = "departments";
configurable string employeeCollection = "employees";
configurable string databaseName = "performanceDB";
configurable string hodsCollection = "hods";

@graphql:ServiceConfig {
    graphiql: {
        enabled: true,
    path: "/graphql"
    }
}
service /performanceSystem on new graphql:Listener(2120){

isolated resource function get AllSupervised(string name) returns Employee[] |error{

lock{
json jsonName = name.toJson(); 
stream<Employee, error?> allEmployees = check dbClient->find(employeeCollection, databaseName,{supervisor: jsonName},{});
Employee[] eachEmployee = check from var employee in allEmployees
select employee; 
return eachEmployee.clone();
}
}

isolated remote function aproveKPI(string staff, string ap) returns error|string {
        
        
        lock{
        json id = staff;
        json aproaval = ap;
          map<json> newKPIaproval = <map<json>>{"$set": {"Aproval": aproaval}};
        int updatedCount = check dbClient->update(newKPIaproval, employeeCollection, databaseName, {staffID: id}, true, false);
        if updatedCount > 0 {
            return "KPI score has been aproved/dissallowed successfully";
        }
        return "Failed to aprove KPI no such staffID";
        }
        
    }

isolated remote function scoreKPI(string staff, string score) returns error|string {
        lock{
        json id = staff;
        json kpiScore = score;
        map<json> newKPIscore = <map<json>>{"$set": {"KPIscore": kpiScore}};
        
         int updatedCount = check dbClient->update(newKPIscore, employeeCollection, databaseName, {staffID: id}, true, false);

        if updatedCount > 0 {
            return "KPI score added successfully";
        }
        return "Failed to score KPI no such staffID";
        }
    }

isolated remote function scoreSupervisor(string staff, string score) returns error|string {
        lock{
        json id = staff;
        json superscore = score;
        map<json> newScore = <map<json>>{"$set": {"Supervisor_Score": superscore}};

        int updatedCount = check dbClient->update(newScore, employeeCollection, databaseName, {staffID: id}, true, false);

        if updatedCount > 0 {
            return "supervisor score added successfully";
        }
        return "error in scoring the supervisior";
        }
    }

isolated remote function addObjecive(string staff, string obj) returns error|string {
        lock{
        json id = staff;
        json objective = obj;
        map<json> newObjective = <map<json>>{"$set": {"departmentObjective": objective}};
        
         int updatedCount = check dbClient->update(newObjective, hodsCollection, databaseName, {staffID: id}, true, false);

        if updatedCount > 0 {
            return "Objective added successfully";
        }
        return "Failed to add objective";
        }
    }

isolated remote function removeObjecive(string staff) returns error|string {
        lock{
        json id = staff;
        map<json> newObjective = <map<json>>{"$set": {"departmentObjective": " "}};
        
         int updatedCount = check dbClient->update(newObjective, hodsCollection, databaseName, {staffID: id}, true, false);

        if updatedCount > 0 {
            return "Objective successfully removed";
        }
        return "Failed toremove objective";
        }
}
isolated remote function addObjecive(string staff, string obj) returns error|string {
        lock{
        json id = staff;
        json objective = obj;
        map<json> newObjective = <map<json>>{"$set": {"departmentObjective": objective}};
        
         int updatedCount = check dbClient->update(newObjective, hodsCollection, databaseName, {staffID: id}, true, false);

        if updatedCount > 0 {
            return "Objective added successfully";
        }
        return "Failed to add objective";
        }
    }
}
