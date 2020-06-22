# Geographic-information-system

It is used to display the locations in MySql database in google maps (google maps ja API). This uses JSP,servlet and Tomcat app server.
### Dependencies
javax.servlet-api-3.0.1.jar

jsp-api-2.2.jar

mysql-connector-java-8.0.20.jar

servlet-api-2.5.jar
### MySql database schema
| Field         | Type         | Null | key | Default | Extra          |
|---------------|--------------|------|-----|---------|----------------|
| id            | int          | NO   | PRI | NULL    | auto_increment |
| business_name | varchar(255) | NO   |     | NULL    |                |
| business_type | varchar(255) | NO   |     | NULL    |                |
| opening_time  | time         | NO   |     | NULL    |                |
| closing_time  | time         | NO   |     | NULL    |                |
| locations     | point        | NO   |     | NULL    |                |
