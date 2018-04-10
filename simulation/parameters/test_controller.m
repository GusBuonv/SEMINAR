function [ controller ] = test_controller()

controller.actuators.actuate = @(controller,x) ...
    controller.actuators.rwheels.actuate(controller);
controller.actuators.rwheels.config = eye(3);
controller.actuators.rwheels.initial_momentum = zeros(3);
controller.actuators.rwheels.actuate = @(controller) ...
    controller.actuators.rwheels.signal;
controller.control_signal = ea2quat([pi;pi*3/8;pi]);
controller.update = @(controller,estimator,params) ...
    setfield(controller,{1},'actuators',{1},'rwheels',{1},'signal',...
    -diag(hybrid(estimator.estimate.state(7:10),...
    estimator.estimate.state(11:13),params.physical.J,...
    controller.control_signal,zeros(3,1),zeros(3,1),1,1)));

end