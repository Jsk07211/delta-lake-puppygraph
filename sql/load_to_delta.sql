-- Ensure schema exists in Unity Catalog
CREATE SCHEMA IF NOT EXISTS puppygraph.demo;

-- USERS
CREATE TABLE IF NOT EXISTS delta.`/delta/demo/Users` (
  user_id BIGINT,
  username STRING,
  email STRING,
  phone STRING,
  created_at TIMESTAMP,
  last_login TIMESTAMP,
  account_status STRING,
  authentication_method STRING,
  failed_login_attempts INT
) USING delta;

INSERT OVERWRITE delta.`/delta/demo/Users`
SELECT
  user_id, username, email, phone,
  CAST(created_at AS TIMESTAMP),
  CAST(last_login AS TIMESTAMP),
  account_status, authentication_method, failed_login_attempts
FROM parquet.`/parquet_data/Users.parquet`;


-- INTERNET GATEWAYS
CREATE TABLE IF NOT EXISTS puppygraph.demo.InternetGateways (
  internet_gateway_id BIGINT,
  name STRING,
  region STRING,
  status STRING
) USING delta
LOCATION 'file:///delta/demo/InternetGateways';

INSERT OVERWRITE puppygraph.demo.InternetGateways
SELECT * FROM parquet.`/parquet_data/InternetGateways.parquet`;

-- ACCESS
CREATE TABLE IF NOT EXISTS puppygraph.demo.UserInternetGatewayAccess (
  user_id BIGINT,
  internet_gateway_id BIGINT,
  access_level STRING,
  granted_at TIMESTAMP,
  expires_at TIMESTAMP,
  last_accessed_at TIMESTAMP
) USING delta
LOCATION 'file:///delta/demo/UserInternetGatewayAccess';

INSERT OVERWRITE puppygraph.demo.UserInternetGatewayAccess
SELECT
  user_id,
  internet_gateway_id,
  access_level,
  CAST(granted_at AS TIMESTAMP),
  CAST(expires_at AS TIMESTAMP),
  CAST(last_accessed_at AS TIMESTAMP)
FROM parquet.`/parquet_data/UserInternetGatewayAccess.parquet`;

-- ACCESS LOG
CREATE TABLE IF NOT EXISTS puppygraph.demo.UserInternetGatewayAccessLog (
  log_id BIGINT,
  user_id BIGINT,
  internet_gateway_id BIGINT,
  access_time TIMESTAMP
) USING delta
LOCATION 'file:///delta/demo/UserInternetGatewayAccessLog';

INSERT OVERWRITE puppygraph.demo.UserInternetGatewayAccessLog
SELECT
  log_id,
  user_id,
  internet_gateway_id,
  CAST(access_time AS TIMESTAMP)
FROM parquet.`/parquet_data/UserInternetGatewayAccessLog.parquet`;

-- VPCS
CREATE TABLE IF NOT EXISTS puppygraph.demo.VPCs (
  vpc_id BIGINT,
  name STRING
) USING delta
LOCATION 'file:///delta/demo/VPCs';

INSERT OVERWRITE puppygraph.demo.VPCs
SELECT * FROM parquet.`/parquet_data/VPCs.parquet`;

-- IGW ↔ VPC
CREATE TABLE IF NOT EXISTS puppygraph.demo.InternetGatewayVPC (
  internet_gateway_id BIGINT,
  vpc_id BIGINT
) USING delta
LOCATION 'file:///delta/demo/InternetGatewayVPC';

INSERT OVERWRITE puppygraph.demo.InternetGatewayVPC
SELECT * FROM parquet.`/parquet_data/InternetGatewayVPC.parquet`;

-- SUBNETS
CREATE TABLE IF NOT EXISTS puppygraph.demo.Subnets (
  subnet_id BIGINT,
  vpc_id BIGINT,
  name STRING
) USING delta
LOCATION 'file:///delta/demo/Subnets';

INSERT OVERWRITE puppygraph.demo.Subnets
SELECT * FROM parquet.`/parquet_data/Subnets.parquet`;

-- SECURITY GROUPS
CREATE TABLE IF NOT EXISTS puppygraph.demo.SecurityGroups (
  security_group_id BIGINT,
  name STRING
) USING delta
LOCATION 'file:///delta/demo/SecurityGroups';

INSERT OVERWRITE puppygraph.demo.SecurityGroups
SELECT * FROM parquet.`/parquet_data/SecurityGroups.parquet`;

-- SUBNET ↔ SG
CREATE TABLE IF NOT EXISTS puppygraph.demo.SubnetSecurityGroup (
  subnet_id BIGINT,
  security_group_id BIGINT
) USING delta
LOCATION 'file:///delta/demo/SubnetSecurityGroup';

INSERT OVERWRITE puppygraph.demo.SubnetSecurityGroup
SELECT * FROM parquet.`/parquet_data/SubnetSecurityGroup.parquet`;

-- NETWORK INTERFACES
CREATE TABLE IF NOT EXISTS puppygraph.demo.NetworkInterfaces (
  network_interface_id BIGINT,
  subnet_id BIGINT,
  security_group_id BIGINT,
  name STRING
) USING delta
LOCATION 'file:///delta/demo/NetworkInterfaces';

INSERT OVERWRITE puppygraph.demo.NetworkInterfaces
SELECT * FROM parquet.`/parquet_data/NetworkInterfaces.parquet`;

-- VM INSTANCES
CREATE TABLE IF NOT EXISTS puppygraph.demo.VMInstances (
  vm_instance_id BIGINT,
  network_interface_id BIGINT,
  role_id BIGINT,
  name STRING
) USING delta
LOCATION 'file:///delta/demo/VMInstances';

INSERT OVERWRITE puppygraph.demo.VMInstances
SELECT * FROM parquet.`/parquet_data/VMInstances.parquet`;

-- ROLES
CREATE TABLE IF NOT EXISTS puppygraph.demo.Roles (
  role_id BIGINT,
  name STRING
) USING delta
LOCATION 'file:///delta/demo/Roles';

INSERT OVERWRITE puppygraph.demo.Roles
SELECT * FROM parquet.`/parquet_data/Roles.parquet`;

-- RESOURCES
CREATE TABLE IF NOT EXISTS puppygraph.demo.Resources (
  resource_id BIGINT,
  name STRING
) USING delta
LOCATION 'file:///delta/demo/Resources';

INSERT OVERWRITE puppygraph.demo.Resources
SELECT * FROM parquet.`/parquet_data/Resources.parquet`;

-- ROLE ↔ RESOURCE
CREATE TABLE IF NOT EXISTS puppygraph.demo.RoleResourceAccess (
  role_id BIGINT,
  resource_id BIGINT
) USING delta
LOCATION 'file:///delta/demo/RoleResourceAccess';

INSERT OVERWRITE puppygraph.demo.RoleResourceAccess
SELECT * FROM parquet.`/parquet_data/RoleResourceAccess.parquet`;

-- PUBLIC IPS
CREATE TABLE IF NOT EXISTS puppygraph.demo.PublicIPs (
  public_ip_id BIGINT,
  ip_address STRING,
  network_interface_id BIGINT
) USING delta
LOCATION 'file:///delta/demo/PublicIPs';

INSERT OVERWRITE puppygraph.demo.PublicIPs
SELECT * FROM parquet.`/parquet_data/PublicIPs.parquet`;

-- PRIVATE IPS
CREATE TABLE IF NOT EXISTS puppygraph.demo.PrivateIPs (
  private_ip_id BIGINT,
  ip_address STRING,
  network_interface_id BIGINT
) USING delta
LOCATION 'file:///delta/demo/PrivateIPs';

INSERT OVERWRITE puppygraph.demo.PrivateIPs
SELECT * FROM parquet.`/parquet_data/PrivateIPs.parquet`;

-- INGRESS RULES
CREATE TABLE IF NOT EXISTS puppygraph.demo.IngressRules (
  ingress_rule_id BIGINT,
  security_group_id BIGINT,
  protocol STRING,
  port_range STRING,
  source STRING
) USING delta
LOCATION 'file:///delta/demo/IngressRules';

INSERT OVERWRITE puppygraph.demo.IngressRules
SELECT * FROM parquet.`/parquet_data/IngressRules.parquet`;

-- INGRESS RULE ↔ IGW
CREATE TABLE IF NOT EXISTS puppygraph.demo.IngressRuleInternetGateway (
  ingress_rule_id BIGINT,
  internet_gateway_id BIGINT
) USING delta
LOCATION 'file:///delta/demo/IngressRuleInternetGateway';

INSERT OVERWRITE puppygraph.demo.IngressRuleInternetGateway
SELECT * FROM parquet.`/parquet_data/IngressRuleInternetGateway.parquet`;

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
FROM parquet.`parquet_data/Users.parquet`;

INSERT INTO puppygraph.demo.InternetGateways
SELECT *
FROM parquet.`parquet_data/InternetGateways.parquet`;

INSERT INTO puppygraph.demo.UserInternetGatewayAccess
SELECT
    user_id,
    internet_gateway_id,
    access_level,
    CAST(granted_at AS TIMESTAMP),
    CAST(expires_at AS TIMESTAMP),
    CAST(last_accessed_at AS TIMESTAMP)
FROM parquet.`parquet_data/UserInternetGatewayAccess.parquet`;

INSERT INTO puppygraph.demo.UserInternetGatewayAccessLog
SELECT
    log_id,
    user_id,
    internet_gateway_id,
    CAST(access_time AS TIMESTAMP)
FROM parquet.`parquet_data/UserInternetGatewayAccessLog.parquet`;

INSERT INTO puppygraph.demo.VPCs
SELECT *
FROM parquet.`parquet_data/VPCs.parquet`;

INSERT INTO puppygraph.demo.InternetGatewayVPC
SELECT *
FROM parquet.`parquet_data/InternetGatewayVPC.parquet`;

INSERT INTO puppygraph.demo.Subnets
SELECT *
FROM parquet.`parquet_data/Subnets.parquet`;

INSERT INTO puppygraph.demo.SecurityGroups
SELECT *
FROM parquet.`parquet_data/SecurityGroups.parquet`;

INSERT INTO puppygraph.demo.SubnetSecurityGroup
SELECT *
FROM parquet.`parquet_data/SubnetSecurityGroup.parquet`;

INSERT INTO puppygraph.demo.NetworkInterfaces
SELECT *
FROM parquet.`parquet_data/NetworkInterfaces.parquet`;

INSERT INTO puppygraph.demo.VMInstances
SELECT *
FROM parquet.`parquet_data/VMInstances.parquet`;

INSERT INTO puppygraph.demo.Roles
SELECT *
FROM parquet.`parquet_data/Roles.parquet`;

INSERT INTO puppygraph.demo.Resources
SELECT *
FROM parquet.`parquet_data/Resources.parquet`;

INSERT INTO puppygraph.demo.RoleResourceAccess
SELECT *
FROM parquet.`parquet_data/RoleResourceAccess.parquet`;

INSERT INTO puppygraph.demo.PublicIPs
SELECT *
FROM parquet.`parquet_data/PublicIPs.parquet`;

INSERT INTO puppygraph.demo.PrivateIPs
SELECT *
FROM parquet.`parquet_data/PrivateIPs.parquet`;

INSERT INTO puppygraph.demo.IngressRules
SELECT *
FROM parquet.`parquet_data/IngressRules.parquet`;

INSERT INTO puppygraph.demo.IngressRuleInternetGateway
SELECT *
FROM parquet.`parquet_data/IngressRuleInternetGateway.parquet`;