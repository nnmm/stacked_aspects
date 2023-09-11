AlphaInfo = provider()
BetaInfo = provider()

def _alpha_impl(target, ctx):
  if AlphaInfo in target:
    return []
  else:
    return [AlphaInfo()]

alpha = aspect(
  implementation = _alpha_impl,
  attr_aspects = ["*"],
  attrs = {
    "_cc_toolchain": attr.label(default = "@bazel_tools//tools/cpp:current_cc_toolchain"),
  },
)

def _beta_impl(target, ctx):
  if AlphaInfo not in target:
    fail("No AlphaInfo in beta")
  return [BetaInfo()]

beta = aspect(
  implementation = _beta_impl,
  attr_aspects = ["*"],
  provides = [BetaInfo],
  requires = [alpha],
)
