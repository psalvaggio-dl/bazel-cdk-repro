"""Wrap pytest"""

load("@aspect_rules_py//py:defs.bzl", "py_test")
load("@pip//:requirements.bzl", "requirement")

def pytest_test(name, srcs, deps = [], args = [], data = [], **kwargs):
    """Call pytest"""
    py_test(
        name = name,
        srcs = [
            "//rules/pytest:main.py",
        ] + srcs,
        main = "//rules/pytest:main.py",
        args = [
            "--capture=no",
            "--import-mode=importlib",
        ] + args + ["$(execpath :%s)" % x for x in srcs],
        deps = deps + [
            requirement("pytest"),
        ],
        data = [
            "//py:pytest.ini",
        ] + data,
        **kwargs
    )
