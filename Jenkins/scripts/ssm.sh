#!/bin/sh

echo "------------------------------------------"
echo $PATH
echo "------------------------------------------"

echo "------------------------------------------"
aws s3 ls
echo "------------------------------------------"

echo "------------------------------------------"
aws ssm send-command --document-name "AWS-RunRemoteScript" \
--document-version "1" \
--targets '[{"Key":"tag:type","Values":["ec2-application-instance"]}]' \
--parameters '{"sourceType":["GitHub"],"sourceInfo":["{ \n\"owner\" : \"VaidheeswaranSrinivasan\",\n\"repository\":\"thoughtworks\",\n\"path\":\"Ansible\"\n}"],"commandLine":["ansible-playbook playbook.yml"],"workingDirectory":[""],"executionTimeout":["3600"]}' \
--comment "mediawiki deployment" \
--timeout-seconds 600 \
--max-concurrency "1" \
--max-errors "0" \
--region eu-west-2
echo "------------------------------------------"