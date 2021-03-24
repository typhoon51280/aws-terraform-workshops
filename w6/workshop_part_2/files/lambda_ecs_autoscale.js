console.log("Starting AWS Lambda function.");
var aws = require('aws-sdk');
 
exports.handler = function(event, context) {
  var ecsService = process.env.ecs_service_name;

  var ecsRegion = 'eu-west-1';
  var ecsCluster = process.env.ecs_cluster_name;
  var ecs = new aws.ECS({region: ecsRegion});
  var autoscaling = new aws.AutoScaling();
  var asg_name = process.env.asg_name;
  
  var context_event_message = event.Records[0].Sns.Message;
  console.log('ASG Scale Event: ' + context_event_message);
  console.log('Going to set desired_count for ECS Service ' + ecsService + ' according to desired_capacity of ASG ' + asg_name + '.');
  autoscaling.describeAutoScalingGroups({AutoScalingGroupNames:[asg_name]}, function(err, data) {
    if (err) {
      console.log(err, err.stack);
    } else {
      var desiredCount = data.AutoScalingGroups[0].DesiredCapacity;
      var params = {
        service:      ecsService,
        desiredCount: desiredCount,
        cluster:      ecsCluster
      };
      ecs.updateService(params, function(err, data) {
        if (err) {
          console.log(err, err.stack);
        } else {
          console.log('Successfully set desired_count of ECS service ' + ecsService + ' to ' + desiredCount);
          context.succeed();
        }
      });
    }
  });
};
