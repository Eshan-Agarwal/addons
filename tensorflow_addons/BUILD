licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

config_setting(
    name = "windows",
    constraint_values = ["@bazel_tools//platforms:windows"],
)

py_library(
    name = "tensorflow_addons",
    data = [
        "__init__.py",
        "options.py",
        "register.py",
        "version.py",
    ],
    deps = [
        "//tensorflow_addons/activations",
        "//tensorflow_addons/callbacks",
        "//tensorflow_addons/image",
        "//tensorflow_addons/layers",
        "//tensorflow_addons/losses",
        "//tensorflow_addons/metrics",
        "//tensorflow_addons/optimizers",
        "//tensorflow_addons/rnn",
        "//tensorflow_addons/seq2seq",
        "//tensorflow_addons/text",
        "//tensorflow_addons/utils",
    ],
)

py_test(
    name = "register_test",
    size = "small",
    srcs = [
        "register_test.py",
    ],
    main = "register_test.py",
    deps = [
        ":tensorflow_addons",
    ],
)
