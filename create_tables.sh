#!/bin/bash
unity_dir=$(dirname "$PWD")/unitycatalog
BASE=${unity_dir}/etc/data/external/puppygraph/
cli="./bin/uc --server http://localhost:9000 "

${cli} catalog create --name puppygraph || true
${cli} schema create --name demo --catalog puppygraph || true

${cli} table create \
  --full_name puppygraph.demo.Users \
  --columns "user_id LONG, username STRING, email STRING, phone STRING, created_at TIMESTAMP, last_login TIMESTAMP, account_status STRING, authentication_method STRING, failed_login_attempts INT" \
  --storage_location "${BASE}/Users" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.InternetGateways \
  --columns "internet_gateway_id LONG, name STRING, region STRING, status STRING" \
  --storage_location "${BASE}/InternetGateways" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.UserInternetGatewayAccess \
  --columns "user_id LONG, internet_gateway_id LONG, access_level STRING, granted_at TIMESTAMP, expires_at TIMESTAMP, last_accessed_at TIMESTAMP" \
  --storage_location "${BASE}/UserInternetGatewayAccess" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.UserInternetGatewayAccessLog \
  --columns "log_id LONG, user_id LONG, internet_gateway_id LONG, access_time TIMESTAMP" \
  --storage_location "${BASE}/UserInternetGatewayAccessLog" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.VPCs \
  --columns "vpc_id LONG, name STRING" \
  --storage_location "${BASE}/VPCs" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.InternetGatewayVPC \
  --columns "internet_gateway_id LONG, vpc_id LONG" \
  --storage_location "${BASE}/InternetGatewayVPC" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.Subnets \
  --columns "subnet_id LONG, vpc_id LONG, name STRING" \
  --storage_location "${BASE}/Subnets" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.SecurityGroups \
  --columns "security_group_id LONG, name STRING" \
  --storage_location "${BASE}/SecurityGroups" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.SubnetSecurityGroup \
  --columns "subnet_id LONG, security_group_id LONG" \
  --storage_location "${BASE}/SubnetSecurityGroup" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.NetworkInterfaces \
  --columns "network_interface_id LONG, subnet_id LONG, security_group_id LONG, name STRING" \
  --storage_location "${BASE}/NetworkInterfaces" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.VMInstances \
  --columns "vm_instance_id LONG, network_interface_id LONG, role_id LONG, name STRING" \
  --storage_location "${BASE}/VMInstances" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.Roles \
  --columns "role_id LONG, name STRING" \
  --storage_location "${BASE}/Roles" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.Resources \
  --columns "resource_id LONG, name STRING" \
  --storage_location "${BASE}/Resources" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.RoleResourceAccess \
  --columns "role_id LONG, resource_id LONG" \
  --storage_location "${BASE}/RoleResourceAccess" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.PublicIPs \
  --columns "public_ip_id LONG, ip_address STRING, network_interface_id LONG" \
  --storage_location "${BASE}/PublicIPs" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.PrivateIPs \
  --columns "private_ip_id LONG, ip_address STRING, network_interface_id LONG" \
  --storage_location "${BASE}/PrivateIPs" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.IngressRules \
  --columns "ingress_rule_id LONG, security_group_id LONG, protocol STRING, port_range STRING, source STRING" \
  --storage_location "${BASE}/IngressRules" \
  --format DELTA

${cli} table create \
  --full_name puppygraph.demo.IngressRuleInternetGateway \
  --columns "ingress_rule_id LONG, internet_gateway_id LONG" \
  --storage_location "${BASE}/IngressRuleInternetGateway" \
  --format DELTA

echo "✅ UC tables created under puppygraph.demo.*"
