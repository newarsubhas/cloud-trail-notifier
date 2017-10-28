Create an S3 bucket where you will send your CloudTrail logs.
```
aws s3api create-bucket --bucket my-account-cloud-trail-logs --region us-east-1

```
Enable CloudTrail and send logs to the bucket created above.
```
aws cloudtrail create-trail --name default --s3-bucket-name my-account-cloud-trail-logs --is-multi-region-trail

```
Create an SNS Topic which will be used to send notifications on the desired logs.
```
aws sns create-topic --name CloudTrailAlerts
```
Subscribe your email address to TopicARN created above.
```
aws sns subscribe --topic-arn arn:aws:sns:us-east-1:502075345842:CloudTrailAlerts --protocol email --notification-endpoint prabhatiitbhu@gmail.com

```
check your mail and confirm subscription

Update the parameter value below with the bucket name and create the role which will be used to execute the Lambda function (via Cloud Formation):

```
aws cloudformation create-stack --stack-name CloudTrailNotifierRole \
                                --template-body file://templates/cloud_trail_notifier_role.json \
                                --parameters ParameterKey=BucketName,ParameterValue=my-account-cloud-trail-logs \
                                --capabilities CAPABILITY_IAM

```
Retrieve the name of the new role.

```
aws cloudformation describe-stacks --stack-name CloudTrailNotifierRole
```
update config.json

```
```
Update path to the the zip file and role below and run to create a Lambda Function name CloudTrailNotifier which will be executed when new logs are placed in the bucket.
```
aws lambda create-function \
        --region us-east-1 \
        --function-name CloudTrailNotifier  \
        --zip-file fileb://build.zip \
        --role arn:aws:iam::502075345842:role/CloudTrailNotifierRole-IAMRole-YRFONR2L5CB5 \
        --handler CloudTrailNotifier.handler \
        --runtime nodejs6.10 \
        --timeout 3 \
        --memory-size 128
```
Update the file notification_configuration.json with the RoleARN and the LambdaARN and run the below to enable S3 Bucket Notifications for new logs to execute the function created above.

```
aws s3api put-bucket-notification-configuration \
        --bucket my-account-cloud-trail-logs \
        --notification-configuration file://templates/notification_configuration.json
```
```
```
```
```
```
