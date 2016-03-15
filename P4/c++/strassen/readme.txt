The implementations

As last time, I've added the scripts to a GIT repository, so feel free to test it on your machine. I will use the I am also happy if you post some of your solutions with running times :-) If you know other languages, you could create a script for these. I focus on Python, Java and C++.

I have implemented only the Strassen algorithm for this post. Please take a look at Wikipedia for a detailed explanation how this algorithm works. 

The important idea of the algorithm is that you break both matrices into four n/2×n/2 matrices and multiply them 
in a clever way. 

Note that you can also use the Strassen algorithm recursively for those n2×n2 matrices. 
You can do this until you have 1×1 matrices which are simple numbers. But it does make sense to stop this recursion and use 
the ikj-algorithm as soon as the matrices are small enough. But what exactly is "small enough"? I'll test that. 
The size when you use the ikj-algorithm is called LEAF_SIZE in my scripts. 
Note that only leaf sizes of multiples of two matter as the size of the (sub-)matrices that get passed to strassenR are 
multiples of two.