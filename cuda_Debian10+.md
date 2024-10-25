# NEW INSTALL DEBIAN 12 - from NVIDIA

Install whole system with Noveau. After follow: [https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html#debian](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html#debian)
For *proprietary drivers*:

```
wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get -V install cuda-drivers
sudo reboot
```

After, [https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#common-installation-instructions-for-debian](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#common-installation-instructions-for-debian):

```
sudo apt-get install cuda-toolkit cudnn
```

# Install Cuda 10 + Tensorflow-gpu on debian 10 buster

# Install new nvidia driver (for maximum compatibility on new Geforce boards)

Download .run from nvidia according your board. This is neccesary for very new boards. After log in alternative tty
(CTRL + ALT + F1) and do: `sudo service stop lightdm` (this is for xfce)

Some prerequisites are: `sudo apt install pkg-config libglvnd-dev`. Finally,

```bash
sudo ./NVIDIA-Linux-x86_64-440.44.run
```


If you don't need this, you cant install driver from repo using: 
```bash
sudo apt install nvidia-driver
```

# Install cuda 10.0 (Compatible with tensorflow)

Download from the deb (local) installer for CUDA 10.0 from the [Nvidia Site](https://developer.nvidia.com/cuda-10.0-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=deblocal). 
You will also need to create a login to download cuDNN.

```bash
sudo dpkg -i cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804-10-0-local-nvjpeg-update-1_1.0-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/7fa2af80.pub
sudo apt update
sudo apt install cuda-libraries-10-0
sudo dpkg -i libcudnn7_7.6.5.32-1+cuda10.0_amd64.deb
```

# Install tensorflow and keras

In a virtualenv (it's a suggestion), do (for 1.15 version):
```bash
pip install tensorflow-gpu==1.15 keras
```

> based on: [https://elec-otago.blogspot.com/2019/05/installing-tensorflow-and-cuda-10-on.html](https://elec-otago.blogspot.com/2019/05/installing-tensorflow-and-cuda-10-on.html)


# Important notes

On GTX2070 and similars, there is some error about *cudnn7*. This error are about tf session configuration.
If use KERAS, this code is a workaround:
```python
import tensorflow as tf
import keras.backend.tensorflow_backend as ktf


def get_session(gpu_fraction=0.333):
    gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=gpu_fraction,
                                allow_growth=True)
    return tf.Session(config=tf.ConfigProto(gpu_options=gpu_options))


ktf.set_session(get_session())

```
> Based on [https://stackoverflow.com/questions/41762272/use-tensorflow-gpuoptions-within-keras-when-using-tensorflow-backend](https://stackoverflow.com/questions/41762272/use-tensorflow-gpuoptions-within-keras-when-using-tensorflow-backend)


# CUDA 10.1 for Linux mint 20

https://towardsdatascience.com/installing-tensorflow-gpu-in-ubuntu-20-04-4ee3ca4cb75d

# CUDA 11.2 Debian 11

sudo apt install nvidia-driver nvidia-cuda-toolkit
Login in [https://developer.nvidia.com/rdp/cudnn-download](https://developer.nvidia.com/rdp/cudnn-download) and, from Archives, **Download cuDNN v8.2.4 (September 2nd, 2021), for CUDA 11.4** (*cuDNN Runtime Library for Ubuntu20.04 x86_64 (Deb)*)

## Test

First test in bash:
Create file cuda_test.sh:
```
#!/bin/bash 
#
# Prints the compute capability of the first CUDA device installed
# on the system, or alternatively the device whose index is the
# first command-line argument


device_index=${1:-0}
timestamp=$(date +%s.%N)
gcc_binary=${CMAKE_CXX_COMPILER:-$(which c++)}
cuda_root=${CUDA_DIR:-/usr/lib/x86_64-linux-gnu}
CUDA_INCLUDE_DIRS=${CUDA_INCLUDE_DIRS:-${cuda_root}/include}
CUDA_CUDART_LIBRARY=${CUDA_CUDART_LIBRARY:-${cuda_root}/libcudart.so}
generated_binary="/tmp/cuda-compute-version-helper-$$-$timestamp"
# create a 'here document' that is code we compile and use to probe the card
source_code="$(cat << EOF 
#include <stdio.h>
#include <cuda_runtime_api.h>
int main()
{
    cudaDeviceProp prop;
    cudaError_t status;
    int device_count;
    status = cudaGetDeviceCount(&device_count);
    if (status != cudaSuccess) { 
        fprintf(stderr,"cudaGetDeviceCount() failed: %s\n", cudaGetErrorString(status)); 
        return -1;
    }
    if (${device_index} >= device_count) {
        fprintf(stderr, "Specified device index %d exceeds the maximum (the device count on this system is %d)\n", ${device_index}, device_count);
        return -1;
    }
    status = cudaGetDeviceProperties(&prop, ${device_index});
    if (status != cudaSuccess) { 
        fprintf(stderr,"cudaGetDeviceProperties() for device ${device_index} failed: %s\n", cudaGetErrorString(status)); 
        return -1;
    }
    int v = prop.major * 10 + prop.minor;
    printf("%d\\n", v);
}
EOF
)"
echo "$source_code" | $gcc_binary -x c++ -I"$CUDA_INCLUDE_DIRS" -o "$generated_binary" - -x none "$CUDA_CUDART_LIBRARY"

# probe the card and cleanup

$generated_binary
rm $generated_binary
```
Execute with: `bash cuda_test.sh`

### Second test (python)

Install a virtualenv with tensorflow and keras and create a test file called `tf_cuda_test.py`:
```
# Installa TensorFlow

import tensorflow as tf
mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10, activation='softmax')
])

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

model.fit(x_train, y_train, epochs=5)

model.evaluate(x_test,  y_test, verbose=2)
```
Execute, inside venv, with: `python tf_cuda_test.py`

### Thirth test (python)

Create file `conv_mnist.py`:
```
import numpy as np
from tensorflow import keras
from tensorflow.keras import layers

# Model / data parameters
num_classes = 10
input_shape = (28, 28, 1)

# the data, split between train and test sets
(x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()

# Scale images to the [0, 1] range
x_train = x_train.astype("float32") / 255
x_test = x_test.astype("float32") / 255
# Make sure images have shape (28, 28, 1)
x_train = np.expand_dims(x_train, -1)
x_test = np.expand_dims(x_test, -1)
print("x_train shape:", x_train.shape)
print(x_train.shape[0], "train samples")
print(x_test.shape[0], "test samples")


# convert class vectors to binary class matrices
y_train = keras.utils.to_categorical(y_train, num_classes)
y_test = keras.utils.to_categorical(y_test, num_classes)

model = keras.Sequential(
    [
        keras.Input(shape=input_shape),
        layers.Conv2D(32, kernel_size=(3, 3), activation="relu"),
        layers.MaxPooling2D(pool_size=(2, 2)),
        layers.Conv2D(64, kernel_size=(3, 3), activation="relu"),
        layers.MaxPooling2D(pool_size=(2, 2)),
        layers.Flatten(),
        layers.Dropout(0.5),
        layers.Dense(num_classes, activation="softmax"),
    ]
)

model.summary()

input("Enter to continue...")

batch_size = 128
epochs = 15

model.compile(loss="categorical_crossentropy", optimizer="adam", metrics=["accuracy"])

model.fit(x_train, y_train, batch_size=batch_size, epochs=epochs, validation_split=0.1)

input("Enter to continue...")

score = model.evaluate(x_test, y_test, verbose=0)
print("Test loss:", score[0])
print("Test accuracy:", score[1])

```
Execute, inside venv, with: `python conv_mnist.py`


# Install on Debian 12.1

Install `sudo apt install nvidia-cuda-toolkit`. Login in [https://developer.nvidia.com/rdp/cudnn-download](https://developer.nvidia.com/rdp/cudnn-download) and, from Archives, **Download cuDNN v8.6.0 (October 3rd, 2022), for CUDA 11.x (Debian 11 deb)**. Install it following this [official guide](https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#installlinux-deb)

After, you must use in your env tensorflow 2.13.
> IMPORTANT: Append `export XLA_FLAGS=--xla_gpu_cuda_data_dir=/usr/lib/cuda` to `.bashrc` file 
