class Tailctl < Formula
  include Language::Python::Virtualenv

  desc "Per-identity Tailscale networking for parallel sessions on a single Mac"
  homepage "https://github.com/DRYCodeWorks/tailctl"
  url "https://files.pythonhosted.org/packages/6a/03/52b84ee70c46d1ee02c6cda7dbf844fa625491da97d1a063baa3524b764f/tailctl-0.1.0.tar.gz"
  sha256 "1eb1d7284bda1a82ed6ec8d014db3ec2a7b22f29e01d931dc6b0f9adc72341c2"
  license "MIT"

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
    # Point the default tailscaled at this machine's Homebrew prefix (Intel != arm64).
    inreplace "src/tailctl/config.py",
              '"/opt/homebrew/opt/tailscale/bin/tailscaled"',
              "\"#{formula_opt_bin("tailscale")}/tailscaled\""

    virtualenv_install_with_resources
  end

  test do
    assert_match "scaffold profiles.yaml", shell_output("#{bin}/tailctl --help")

    # `init`/`up` need a signed-in Tailscale.app, so verify the prefix rewrite instead.
    config = Pathname.glob(libexec/"lib/python*/site-packages/tailctl/config.py").first
    assert_match "#{formula_opt_bin("tailscale")}/tailscaled", config.read
  end
end
