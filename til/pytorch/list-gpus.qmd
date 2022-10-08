In Pytorch, you can list number of available GPUs using `torch.cude.device_count()`.

- If you specify **cpu** as a device such as `torch.device("cpu")`, this means all available CPUs/cores and memory will be used in the computation of tensors.
- If you specify **cuda** as a device such as `torch.device("cuda")`, it is the same as `torch.device("cuda:0")` which is the first GPU and memory.
- Otherwise, specify which GPU you want using `torch.device("cuda:{i}")` for the **ith** device.
