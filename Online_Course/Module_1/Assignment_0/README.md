# 🚀 Kernel Module Exploration: M1-S2-A0 🚀

Welcome to the first assignment in our kernel module exploration! Dive into the world of processes, priorities, and cores. Ready to get started?

## 🎯 Tasks

### 1. 🧮 **Discover Your Cores**:
   - Fire up the terminal and use the `top` command. Can you find out how many cores your machine is running on?
![1](https://github.com/t0ti20/Embedded_Linux/assets/61616031/1ea8adae-a7fd-4d27-9f5f-55f5f2880683)

### 2. 🔄 **Spinning Processes**:
   - Let's create some processes! But not just any number. Calculate the number of cores you have and add two. That's the number of `dd if=/dev/zero of=/dev/null` processes you need to run in the background. Can you handle the challenge?
![2](https://github.com/t0ti20/Embedded_Linux/assets/61616031/fe473bb6-6f98-4c20-8964-c994058dd115)

### 3. 🎚 **Shuffling Priorities**:
   - It's time to juggle! Change the priority of the processes you just created. Start from `-20`, and increment by 10 until you reach `0`, then increment by one all the way to `19`. 
![3](https://github.com/t0ti20/Embedded_Linux/assets/61616031/560fb80b-f394-4a82-afd3-b1b382edea28)
![4](https://github.com/t0ti20/Embedded_Linux/assets/61616031/dcb81876-ba29-414c-a66c-639fb3270afc)

### 4. 🖥 **Monitor the Madness**:
   - Go back to the `top` command and keep a watchful eye on the processes. Spot any differences? Record what you observe!

### 5. 🚫 **Enough Chaos! Stop the Processes**:
   - Let's wind down. Use the `killall` command to stop all the processes you started.
![5](https://github.com/t0ti20/Embedded_Linux/assets/61616031/ca6ed8a2-5a75-401e-a788-820740446f42)

## 📤 What to Submit

- **Command Chronicle**: Create a file documenting all the commands you've used throughout this exercise.
  
- **Visual Evidence (Optional)**: If you're feeling fancy, take some screenshots of your process. It's always great to have a visual trail!

