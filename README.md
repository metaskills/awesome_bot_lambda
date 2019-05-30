
# README

Little AWS Lambda to validate links in awesome projects. Uses the [Lamby](https://github.com/customink/lamby) gem for simple Rails & AWS Lambda intgration along with the [awesome_bot](https://github.com/dkhamsing/awesome_bot) gem.


## Setup

#### Installing AWS CLI & SAM

If you have these installed skip this setp. However, each are fairly easy on Macs using Homebrew. For other platforms or first time installers, please follow the [full guides](https://github.com/customink/lamby/issues/18) and configure your AWS CLI before proceeding.

```shell
$ brew install awscli
$ brew tap aws/tap
$ brew install aws-sam-cli
```

#### Create CloudFormation S3 Bucket

You can change this in your `bin/deploy` script or use the `CLOUDFORMATION_BUCKET` environment varable.

```shell
aws s3 mb "s3://lamby.cloudformation.awesomebotlambda"
```

#### Configuration

Create the SSM Parameter store for the `RAILS_MASTER_KEY`. WARNING: This is checked into git source only so I can share this project. Please change/delete if you fork it.

```shell
aws ssm put-parameter \
  --name "/config/awesomebotlambda/env/RAILS_MASTER_KEY" \
  --type "SecureString" \
  --value $(cat config/master.key)
```

#### Deploy!

Use the local deploy script to package and deploy with AWS SAM.

```shell
$ ./bin/deploy
```

To see your newly created Lambda's API Gateway URL, run the following. This will describe the CloudFormation stack we just deployed and the `Outputs` from that template.

```shell
aws cloudformation describe-stacks \
  --stack-name "awesomebotlambda-production-us-east-1" | \
  grep OutputValue | \
  grep https
```
