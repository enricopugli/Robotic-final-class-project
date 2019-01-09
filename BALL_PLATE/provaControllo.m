A1 = [0 1 0;
      0 0 1;
      0 0 0];

A = blkdiag(A1,A1);

B = [0 0;
     0 0;
     1 0;
     0 0;
     0 0;
     0 1];
 
C = [1 0 0 0 0 0;
     0 0 0 1 0 0];

D = zeros(2,2);
 
sys_MIMO = ss(A,B,C,D);

tf_1 = tf(sys_MIMO);
