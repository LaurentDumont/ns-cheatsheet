### Profiling a python application.
```python
pip3 install line_profiler
python3 -m line_profiler tag-exporter.py.lprof
```

```
Timer unit: 1e-06 s

Total time: 2e-06 s
File: tag-exporter.py
Function: __init__ at line 13

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    13                                               @profile
    14                                               def __init__(self):
    15         1          2.0      2.0    100.0          self._endpoint = '6666'

Total time: 14.99 s
File: tag-exporter.py
Function: collect at line 17

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    17                                               @profile
    18                                               def collect(self):
    19         5        115.0     23.0      0.0          GITLAB_PROJECTS_ID_LIST = os.getenv('GITLAB_PROJECTS_ID').split(',')
    20         5         47.0      9.4      0.0          GITLAB_API_TOKEN = os.getenv('GITLAB_API_TOKEN')
    21                                           
    22         5      25743.0   5148.6      0.2          gl = gitlab.Gitlab('https://gitlab.gitlab.maker.studio', private_token=GITLAB_API_TOKEN, ssl_verify=False)
    23                                           
    24                                           
    25        23         28.0      1.2      0.0          for project_id in GITLAB_PROJECTS_ID_LIST:
    26        19    4103967.0 215998.3     27.4              project = gl.projects.get(project_id)
    27        19    2781067.0 146371.9     18.6              tags = project.tags.list(per_page='1')
    28                                                       # Get most recent tag - the tag list is returned 
    29        19        189.0      9.9      0.0              latest_tag = tags[0]
    30                                           
    31                                           
    32        19         66.0      3.5      0.0              gitlab_tag_metric = Metric('gitlab_tag_version',
    33        19        494.0     26.0      0.0          'Latest Gitlab tags for the project', 'summary')
    34        19         73.0      3.8      0.0              gitlab_tag_metric.add_sample('gitlab_tag_version',
    35        19        822.0     43.3      0.0          value='0', labels={'tag_version':str(latest_tag.name), 'project_name':str(project.name)})
    36        19         51.0      2.7      0.0              yield gitlab_tag_metric
    37                                           
    38                                                       # Get the .gitlab-ci.yml from reach project in order to validate the target from the releases
    39        18    4162769.0 231264.9     27.8              file_content = project.files.raw('.gitlab-ci.yml', 'master')
    40        18    3913465.0 217414.7     26.1              test = yaml.safe_load(file_content)
    41       144        132.0      0.9      0.0              for library_name, version_value in test['variables'].items():
    42       126         85.0      0.7      0.0                  if 'VERSION' in library_name:
    43        54         32.0      0.6      0.0                      library_version = version_value
    44        54         39.0      0.7      0.0                      project_version_req = Metric('project_version_req',
    45        54        287.0      5.3      0.0                      'Project versions requirements in Master branch', 'summary')
    46        54         39.0      0.7      0.0                      project_version_req.add_sample('project_version_req',
    47        54        432.0      8.0      0.0                      value='0', labels={'project':str(project.name), 'library_name':str(library_name),'target_version':str(library_version)})
    48        54         38.0      0.7      0.0                      yield project_version_req
```