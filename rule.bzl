load(":aspects.bzl", "BetaInfo")
load(":aspects.bzl", "beta")

def _aspect_consumer_impl(ctx):
  if BetaInfo not in ctx.attr.cc:
    fail("No BetaInfo in aspect_consumer")
  return []
  
aspect_consumer = rule(
  implementation = _aspect_consumer_impl,
  attrs = {
    "cc": attr.label(
      providers = [CcInfo],
      aspects = [beta],
    )
  },
)
