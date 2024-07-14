# General
Set up AWS infrastructure.

## Commands
### Upload static website
https://s3.eu-central-1.amazonaws.com/my.static.cv.website.14.07/index.html
https://s3.eu-central-1.amazonaws.com/my.static.cv.website.14.07/error.html
```bash
aws s3 cp modules/aws-s3-static-website-bucket/www/ s3://$(terraform output -raw website_bucket_name)/ --recursive
```
### Remove bucket
```bash
aws s3 rm s3://$(terraform output -raw website_bucket_name)/ --recursive
```