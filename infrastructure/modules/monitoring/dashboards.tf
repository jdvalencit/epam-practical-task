resource "aws_cloudwatch_dashboard" "ec2-dashboar" {
  dashboard_name = "EC2 Dashboard - ${terraform.workspace}"
  dashboard_body = jsonencode({
    widgets = [{
      type   = "metric"
      x      = 0
      y      = 0
      width  = 12
      height = 6

      properties = {
        metrics = [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            ""
          ]
        ]
        period = 300
        stat   = "Average"
        region = "us-east-1"
        title  = "EC2 Instance CPU"
      }
      },
      {
        type   = "text"
        x      = 0
        y      = 7
        width  = 3
        height = 3

        properties = {
          markdown = "Hello world"
        }
    }]
  })
}