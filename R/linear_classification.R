#devtools::install_github("rstudio/tensorflow")
#library(tensorflow)
#install_tensorflow()
#miniconda install
#hello <- tf$constant("Hello")
#print(hello)


#creating two random blobs of points that will be the targets of the program
#the tensorflow will attempt to work out which points is in which group
#and will then draw a line that neatly divides them, using the weights
#it has decided on to calculate the gradient of the line, and the second weight and bias
#to calculate the intercept
num_samples_per_class <- 1000
Sigma <- rbind(c(1, 0.5), c(0.5, 1))
#two arrays of dimensions (1000, 2), 1000 x and y points. These are two classes of points:
#the 0 class if in the first array of 1000, the 1 class if in the second array of 1000
#this will feel like the wrong way round in a moment...
negative_samples <- MASS::mvrnorm(n = num_samples_per_class, mu = c(0, 3), Sigma = Sigma)
positive_samples <- MASS::mvrnorm(n = num_samples_per_class, mu = c(3, 0), Sigma = Sigma)
#stacked on top of each other or 'r-bound' into an array of (2000, 2)- x and y points 
inputs <- rbind(negative_samples, positive_samples)
#an array of targets are then produced, of 1's if the point is in the zero class
#of 0's if the point in the first class 
targets <- rbind(array(0, dim = c(num_samples_per_class, 1)), array(1, dim = c(num_samples_per_class, 1)))
plot(x = inputs[,1], y = inputs[,2], col = ifelse(targets[,1] == 0, "purple", "green"))
input_dim <- 2
output_dim <- 1
#setting up of weights and biases
W <- tf$Variable(initial_value = tf$random$uniform(shape(input_dim, output_dim)))
b <- tf$Variable(initial_value = tf$zeros(shape(output_dim)))
model <- function(inputs)
  tf$matmul(inputs, W) + b
#loss function checking if predicted points are as close as possible to target points
square_loss <- function(targets, predictions){
  per_sample_losses <- (targets - predictions)^2
  mean(per_sample_losses)
}
#arbitrarily set up learning rate
learning_rate <- 0.1
training_step <- function(inputs, targets){
  with(tf$GradientTape() %as% tape, {
    predictions <- model(inputs)
    loss <- square_loss(predictions, targets)
  })
  grad_loss_wrt <- tape$gradient(loss, list(W = W, b = b))
  W$assign_sub(grad_loss_wrt$W * learning_rate)
  b$assign_sub(grad_loss_wrt$b * learning_rate)
  loss
}
inputs <- as_tensor(inputs, dtype = "float32")
for (step in seq(40)) {
  loss <- training_step(inputs, targets)
  cat(sprintf("Loss at step %s: %.4f\n", step, loss))
}
predictions <- model(inputs)
inputs <- as.array(inputs)
predictions <- as.array(predictions)
plot(inputs[,1], inputs[,2], col = ifelse(predictions[,1] <= 0.5, "yellow", "maroon"))
slope <- -W[1,]/W[2,]
intercept <- (0.5-b)/W[2,]
abline(as.array(intercept), as.array(slope), col = "red")
paste("y = ", slope, "x", intercept)