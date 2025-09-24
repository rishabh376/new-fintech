output "app_url" {
  value = "http://${aws_lb.fintech_app.dns_name}"
}

output "db_endpoint" {
  value = "${aws_db_instance.fintech_db.endpoint}"
}

output "bucket_name" {
  value = "${aws_s3_bucket.fintech_bucket.bucket}"
}