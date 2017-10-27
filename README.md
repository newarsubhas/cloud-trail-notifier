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
