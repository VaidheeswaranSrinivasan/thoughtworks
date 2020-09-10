#!/bin/sh

function set_aws_credentials
{
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  
  role_arn="arn:aws:iam::"${Account_Number}":role/JenkinsRole"
  aws_credentials_json=$(aws sts assume-role --role-arn "$role_arn" --role-session-name "${Account_Number}" --region eu-west-2)
  export AWS_ACCESS_KEY_ID=$(echo $aws_credentials_json | jq --exit-status --raw-output .Credentials.AccessKeyId)
  export AWS_SECRET_ACCESS_KEY=$(echo $aws_credentials_json | jq --exit-status --raw-output .Credentials.SecretAccessKey)
  export AWS_SESSION_TOKEN=$(echo $aws_credentials_json | jq --exit-status --raw-output .Credentials.SessionToken)
}

set +x

echo "--------------------------------"
echo "Main execution begins"
echo "--------------------------------"

echo "$PATH"

set_aws_credentials

ssm_run_command="aws ssm send-command --document-name \"arn:aws:ssm:eu-west-2:456771736854:document/AnsiblePlaybook\" \
--targets '[$target_tags]' \
--parameters '{\"sourceType\":[\"GitHub\"],\"sourceInfo\":[\"{\\\"owner\\\":\\\"VaidheeswaranSrinivasan\\\",\\\"repository\\\":\\\"thoughtworks-project\\\"}\"],\"extravars\":[\"$ansible_extravars\"],\"tags\":[\"$ansible_tags\"],\"check\":[\"False\"],\"workingDirectory\":[\"\"],\"executionTimeout\":[\"3600\"]}' \
--comment \"$ssm_command_description\" \
--timeout-seconds 600 \
--max-concurrency \"1\" \
--max-errors \"0\" \
--region eu-west-2"

echo "--------------------------------"
echo "$ssm_run_command"
echo "--------------------------------"

eval status=\$\("$ssm_run_command"\)