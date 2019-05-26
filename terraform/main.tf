provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "slides" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"
  policy = <<EOF
{
"Version":"2012-10-17",
"Statement":[{
"Sid":"PublicReadGetObject",
      "Effect":"Allow",
  "Principal": "*",
    "Action":["s3:GetObject"],
    "Resource":["arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
]
}
EOF
  website {
    index_document = "index.html"
  }
}

output "aws_bucket_url" {
  value = "${aws_s3_bucket.slides.bucket_regional_domain_name}"
}

# output "aws_website_url" {
#   value = "${aws_s3_bucket.slides.website_domain}"
# }
