INSERT INTO puppygraph.demo.Users
SELECT
    user_id,
    username,
    email,
    phone,
    CAST(created_at AS TIMESTAMP),
    CAST(last_login AS TIMESTAMP),
    account_status,
    authentication_method,
    failed_login_attempts
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/Users.parquet`;

INSERT INTO puppygraph.demo.InternetGateways
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/InternetGateways.parquet`;

INSERT INTO puppygraph.demo.UserInternetGatewayAccess
SELECT
    user_id,
    internet_gateway_id,
    access_level,
    CAST(granted_at AS TIMESTAMP),
    CAST(expires_at AS TIMESTAMP),
    CAST(last_accessed_at AS TIMESTAMP)
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/UserInternetGatewayAccess.parquet`;

INSERT INTO puppygraph.demo.UserInternetGatewayAccessLog
SELECT
    log_id,
    user_id,
    internet_gateway_id,
    CAST(access_time AS TIMESTAMP)
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/UserInternetGatewayAccessLog.parquet`;

INSERT INTO puppygraph.demo.VPCs
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/VPCs.parquet`;

INSERT INTO puppygraph.demo.InternetGatewayVPC
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/InternetGatewayVPC.parquet`;

INSERT INTO puppygraph.demo.Subnets
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/Subnets.parquet`;

INSERT INTO puppygraph.demo.SecurityGroups
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/SecurityGroups.parquet`;

INSERT INTO puppygraph.demo.SubnetSecurityGroup
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/SubnetSecurityGroup.parquet`;

INSERT INTO puppygraph.demo.NetworkInterfaces
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/NetworkInterfaces.parquet`;

INSERT INTO puppygraph.demo.VMInstances
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/VMInstances.parquet`;

INSERT INTO puppygraph.demo.Roles
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/Roles.parquet`;

INSERT INTO puppygraph.demo.Resources
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/Resources.parquet`;

INSERT INTO puppygraph.demo.RoleResourceAccess
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/RoleResourceAccess.parquet`;

INSERT INTO puppygraph.demo.PublicIPs
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/PublicIPs.parquet`;

INSERT INTO puppygraph.demo.PrivateIPs
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/PrivateIPs.parquet`;

INSERT INTO puppygraph.demo.IngressRules
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/IngressRules.parquet`;

INSERT INTO puppygraph.demo.IngressRuleInternetGateway
SELECT *
FROM parquet.`file:///Users/jazku/Desktop/delta-lake-puppygraph/parquet_data/IngressRuleInternetGateway.parquet`;