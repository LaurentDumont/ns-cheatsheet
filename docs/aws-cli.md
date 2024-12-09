## ACM


Useful things
 - Use `no-cli-pager` to send the result directly to the terminal and not to `less`
   - There is a bug for the help menu --> https://github.com/aws/aws-cli/issues/4972
   - You can send it to `cat` as a workaround --> `aws ec2 help | cat`
 - There is an autocomplete built into the CLI
   - You can use `--cli-auto-prompt` with each prompt

### List certificates
```
aws acm list-certificates --output json --no-cli-pager --query 'CertificateSummaryList[*].CertificateArn'
```

### ACM Delete certificates
```
for arn in $(aws acm list-certificates --output json --no-cli-pager --query 'CertificateSummaryList[*].CertificateArn' | jq -r '.[]'); do aws acm delete-certificate --certificate-arn "$arn"; done
```

## CodeCommit

Note, this service is deprecated by AWS. You should stop current usage and migrate to SCM alternatives (Gitlab, Github and others)

### List repositories
```
aws codecommit list-repositories --no-cli-pager
```

### Delete repositories
```
aws codecommit delete-repository --repository-name gremlins-api
```

## API Gateway

Note the apigatewayv2 in some cases

Get a custom domain name
```
aws apigateway get-domain-names --no-cli-pager --query 'items[*]['regionalCertificateArn','domainName']' | jq -r '.[]'
```

Delete a custom domain name
```
aws apigateway delete-domain-name --domain-name sig.coldnorthadmin.com
```

Get an API
```
aws apigatewayv2 get-apis --query 'Items[*]['ApiId']' --no-cli-pager
```

Delete an API
```
aws apigatewayv2 delete-api --api-id 80wxwwwn2l
```

## EC2

### Delete Security Groups
```
aws ec2 describe-security-groups --query "SecurityGroups[*].GroupName" --no-cli-pager --output json | jq -r '.[]' | while IFS= read -r sg; do aws ec2 delete-security-group --group-name $sg; done 
```

### Delete key pairs
```
aws ec2 describe-key-pairs --query "KeyPairs[*].KeyName" --no-cli-pager | jq -r '.[]' | while IFS= read -r key; do aws ec2 delete-key-pair --key-name $key --no-cli-pager; done
```