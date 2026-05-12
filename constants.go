package website

const (
	DefaultNginxContainerImage = "ghcr.io/cybozu-go/website-operator-nginx:1.28.3.0"
	WebSiteIndexField          = ".status.ready"
)

var DefaultRepoCheckerContainerImage = "ghcr.io/cybozu-go/repo-checker:" + Version
