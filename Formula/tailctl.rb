class Tailctl < Formula
  include Language::Python::Virtualenv

  desc "Per-identity Tailscale networking for parallel sessions on a single Mac"
  homepage "https://github.com/DRYCodeWorks/tailctl"
  url "https://files.pythonhosted.org/packages/24/88/2459c0d2342ed8bfe19f13e464eeff0f4229c265c5870b678bae42720c34/tailctl-0.2.1.tar.gz"
  sha256 "353dc7413b8ce56e16a3e566fdd2ea6b132db5cca736dc9b2a90d0461411b8c3"
  license "MIT"

  # Bumps here are manual, so let `brew livecheck` spot new PyPI releases.
  livecheck do
    url :stable
    strategy :pypi
  end

  # Pure Python, so it installs anywhere — but `init` discovers accounts through
  # Tailscale.app, and macOS is the only platform upstream claims or tests.
  depends_on :macos
  depends_on "python@3.13"
  depends_on "tailscale"

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/c6/d1ddf4abb55e93cebc4f2ed8b5d6dbad109ecb8d63748dd2b20ab5e57ebe/psutil-7.2.2.tar.gz"
    sha256 "0746f5f8d406af344fd547f1c8daa5f5c33dbc293bb8d6a16d80b4bb88f59372"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "scaffold profiles.yaml", shell_output("#{bin}/tailctl --help")

    # `init`/`up` need a signed-in Tailscale.app, so just check that tailctl
    # resolves a real tailscaled instead of a hardcoded prefix that may not exist.
    resolved = shell_output("#{libexec}/bin/python -c " \
                            "'import tailctl.config as c; print(c.DEFAULT_TAILSCALED)'").strip
    assert_predicate Pathname(resolved), :executable?
  end
end
