GitHub Actions: Generate Docker Image Tag
===

## How to use

Add to your steps at certain job:

```yaml
# Add usage of action:
- name: Get Docker image tag for ghcr.io
  id: docker-image-tag
  uses: Danand/docker-image-tag@v1
  with:
    product-name: 'my-app'
    service-suffix: 'api' # Optional.
    input-version: '1.2.3' # Optional. Overrides tag fetched from Git.
- name: Assign tag for Docker image
  shell: bash
  run: docker -t "my-app-api:1.2.3" "${{ steps.docker-image-tag.outputs.image-tag }}"
```

Expected output of `${{ steps.docker-image-tag.outputs.image-tag }}`:

```bash
ghcr.io/my-user-name/my-repo/my-app-api-1.2.3
```
