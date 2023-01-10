stages:
  - build
  - merge-request

build_image_with_kaniko:
  stage: build
  image:
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  script:
    - |
      cat > /kaniko/.docker/config.json <<EOF
      {
        "credsStore": "ecr-login"
      }
      EOF
      /kaniko/executor --context $CI_PROJECT_DIR --dockerfile $CI_PROJECT_DIR/Dockerfile --destination $ECR_URI/${group}/${project}:$CI_COMMIT_SHORT_SHA

release_manifests:
  stage: merge-request
  image:
    name: alpine/git:latest
    entrypoint: [""]
  script:
    - |
      git config --global user.name gitlab
      git config --global user.email gitlab@mail.domain
      git checkout -b $CI_COMMIT_SHORT_SHA
      sed -i 's/image: ${ecr_uri}\/${group}\/${project}:\(.*\)/image: ${ecr_uri}\/${group}\/${project}:'$CI_COMMIT_SHORT_SHA'/' ./manifests/deployment.yaml 
      git add -A
      git commit -m '[ci skip] image update'
      git push http://group_${ci_user}_bot:$PAT@gitlab-webservice-default.gitlab.svc.cluster.local/${group}/${project} $CI_COMMIT_SHORT_SHA
      apk update
      apk add curl
      curl -X POST --header "PRIVATE-TOKEN: ${gitlab_token}" --header "Content-Type: application/json" --data '{"source_branch": "$CI_COMMIT_SHORT_SHA", "target_branch": "main", "title": "auto merge request"}' ${gitlab_url}${gitlab_api}projects/${project_path}/merge_requests
