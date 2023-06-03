resource "aws_s3_bucket" "test_bucket_rohit_chua" {
  bucket = "my-tf-test-bucket-rohit-chua"

  tags = {
    Name        = "Test Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "rohit_bucket_owner" {
  bucket = aws_s3_bucket.test_bucket_rohit_chua.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# resource "aws_s3_bucket_public_access_block" "rohit_bucket_public" {
#   bucket = aws_s3_bucket.test_bucket_rohit_chua.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

resource "aws_s3_bucket_acl" "rohit_bucket_acl" {

  depends_on = [
    aws_s3_bucket_ownership_controls.rohit_bucket_owner
  ]

  bucket = aws_s3_bucket.test_bucket_rohit_chua.id
  acl = "private"
}

resource "aws_s3_bucket_versioning" "rohit_bucket_version" {
  bucket = aws_s3_bucket.test_bucket_rohit_chua.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.test_bucket_rohit_chua.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}