# ACOr in reversing car with sugeno(TSK) type fuzzy controller
Train fuzzy controller with Ant Colony Optimization(continuous domain) for reversing car

Overview : 
1. Here is sugeno type fuzzy control model.
2. The file called “SUGENOwithACO.m” is the main code.
3. The file called "controlModel_trained.fis" is a trained model which can be used for "test.m".
4. Following the main code guide, the GA will start to evolve our fuzzy controller to reach our goal!

Our goal :
1. The goal is reversing the car(represented as a triangle, the sharp angle is the head of the car) to the location around  
   (50,100) with the angle "phi"(calculated from the x-axis to the axis that crosses the head and the tail of the car) around 
   90 degrees.
2. Minimizing "docking_error", which is defined as below: ![alt tag](https://user-images.githubusercontent.com/34533532/34327700-3578bb22-e906-11e7-9ac8-0cfdaeec7aca.png)

   X_f is equals to 50, Y_f is equals to 100 and Phi_f is equals to 90 degrees.
3. You can find there are a "trajectory_error" in the code, which is only used for seeing how efficiency of the car reversing.![alt tag](https://user-images.githubusercontent.com/34533532/34327701-35a1c54e-e906-11e7-8682-e48372597710.png)

Parameter : 
1. X is ranges from 0 to 100
2. Y is ranges from 0 to 100
3. Phi is ranges from -90 to 270 degrees
4. Theta(represented as the angle of the tire can rotate) is ranges from -30 to 30 degrees

Insight : 
1. We only need a few of ants, say 2 or 10

Learning Curve : 
![alt tag](https://user-images.githubusercontent.com/34533532/34327699-3546900c-e906-11e7-8a32-bae7ea3b2367.png)

Reference : Krzysztof Socha, Marco Dorigo, Ant colony optimization for continuous domains
