load("@pip//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", _py_test = "py_test")

def pylint_test(target_name, srcs, args = []):
    _py_test(
        name = target_name + "-pylint",
        srcs = ["//rules/python/tools/pylint:wrapper.py"],
        main = "//rules/python/tools/pylint:wrapper.py",
        python_version = "PY3",
        data = ["//py:.pylintrc"] + srcs,
        deps = [
            target_name,
            requirement("pylint"),
        ],
        args = [
            "--rcfile",
            "$(execpath //py:.pylintrc)",
        ] + args + ["$(execpath :%s)" % x for x in srcs],
        tags = ["no-sandbox"],
    )
