function xkp1 = dynamics(xk, uk, dt, noise_sigma)
    
    xkp1 = zeros(size(xk,1),1);
    xkp1(1)   = xk(1) + uk(1)*cos(xk(3))*dt + normrnd(0, noise_sigma(1));
    xkp1(2)   = xk(2) + uk(1)*sin(xk(3))*dt + normrnd(0, noise_sigma(2));
    xkp1(3)   = xk(3) + uk(2)*dt            + normrnd(0, noise_sigma(3));
    
end