#!/bin/sh

echo $PATH

aws s3 ls

aws ssm send-command --document-name "AWS-RunRemoteScript" \
--document-version "1" \
--parameters '{"sourceType":["GitHub"],"sourceInfo":["{\n\"owner\" : \"VaidheeswaranSrinivasan\",\n\"repository\":\"thoughtworks\",\n\"path\":\"Ansible\"\n}"],"commandLine":["ansible-playbook playbook.yml"],"workingDirectory":[""],"executionTimeout":["3600"]}' \
--comment "Ansible Playbook Deployment" \
--timeout-seconds 600 \
--max-concurrency "50" \
--max-errors "0" \
--region eu-west-2