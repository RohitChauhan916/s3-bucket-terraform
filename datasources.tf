data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${var.user_identity}"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.test_bucket_rohit_chua.arn,
      "${aws_s3_bucket.test_bucket_rohit_chua.arn}/*",
    ]
  }
}