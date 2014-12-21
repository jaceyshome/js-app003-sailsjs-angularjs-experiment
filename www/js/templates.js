define(['angular'], function() {angular.module('templates', []).run([ '$templateCache', function($templateCache) {  'use strict';

  $templateCache.put('app/states/home/home',
    "<div class=home><h3>Home page</h3></div>"
  );


  $templateCache.put('app/states/login/login',
    "<h2>Log in</h2><div class=loginContainer><form name=loginForm class=form-login><div data-ng-class=\"{'has-error': loginForm.name.$invalid &amp;&amp; !loginForm.name.$pristine}\" class=form-group><label>Name</label><input placeholder=\"your name\" name=name required data-ng-model=user.name maxlength=100 class=\"form-control\"><p data-ng-show=\"loginForm.name.$invalid &amp;&amp; !loginForm.name.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': loginForm.password.$invalid &amp;&amp; !loginForm.password.$pristine}\" class=form-group><label>Password</label><input type=password placeholder=password name=password required data-ng-model=user.password maxlength=100 class=\"form-control\"><p data-ng-show=\"loginForm.password.$invalid &amp;&amp; !loginForm.password.$pristine\" class=error>Required.</p></div><button type=submit data-ng-click=sumbit() class=\"btn btn-lg btn-primary btn-block\">Log in</button></form><a data-ng-click=goToSignup() class=\"btn btn-lg btn-primary btn-block\">Sign up</a></div>"
  );


  $templateCache.put('app/states/project/details/details',
    "<div class=\"container projectDetail\"><h3>project detail pages</h3><p>{{project.name}}</p><p>{{project.description}}</p><p>{{project.stateId}}</p><p>{{project.startDate}}</p><p>{{project.endDate}}</p><p>{{project.priority}}</p><a data-ng-click=edit() href=javascript:void(0) class=\"btn btn-medium btn-primary\">Edit</a></div>"
  );


  $templateCache.put('app/states/project/edit/edit',
    "<div class=\"container projectEdit\"><h3>project edit</h3><div class=projectForm><form name=projectForm><div data-ng-class=\"{'has-error': projectForm.name.$invalid &amp;&amp; !projectForm.name.$pristine}\" class=form-group><label>Project Name</label><input placeholder=\"user name\" name=name required data-ng-model=project.name maxlength={{attributes.name.maxLength}} class=\"form-control\"><p data-ng-show=\"projectForm.name.$invalid &amp;&amp; !projectForm.name.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': projectForm.description.$invalid &amp;&amp; !projectForm.description.$pristine}\" class=form-group><label>Project Description</label><textarea placeholder=\"project description\" name=description data-ng-model=project.description rows=5 class=form-control></textarea></div></form></div><a data-ng-click=submit() href=javascript:void(0) class=\"btn btn-medium btn-primary\">Submit</a></div>"
  );


  $templateCache.put('app/states/project/list/list',
    "<div class=\"container userList\"><h3>Project List</h3><div class=container><ul><li data-ng-repeat=\"project in projects\"><a data-ng-click=show(project) href=javascript:void(0);><span>{{project.name}}</span></a><a data-ng-click=edit(project) href=javascript:void(0);><span>edit</span></a><a data-ng-click=destroy(project) href=javascript:void(0);><span>delete</span></a></li></ul></div></div>"
  );


  $templateCache.put('app/states/project/new/new',
    "<div class=\"container projectNew\"><h3>New Project</h3><div class=projectForm><form name=projectForm><div data-ng-class=\"{'has-error': projectForm.name.$invalid &amp;&amp; !projectForm.name.$pristine}\" class=form-group><label>Project Name</label><input placeholder=\"project name\" name=name required data-ng-model=project.name maxlength={{attributes.name.maxLength}} class=\"form-control\"><p data-ng-show=\"projectForm.name.$invalid &amp;&amp; !projectForm.name.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': projectForm.description.$invalid &amp;&amp; !projectForm.description.$pristine}\" class=form-group><label>Project Description</label><textarea placeholder=\"project description\" name=description data-ng-model=project.description rows=5 class=form-control></textarea></div></form></div><a data-ng-click=addStage() href=javascript:void(0) class=\"btn btn-medium btn-primary\">Add Stage</a><div data-ng-if=project.stages.length&gt;0 class=row><div class=col-md-6><div ui-tree=ui-tree><ol ui-tree-nodes=\"\" ng-model=project.stages><li ng-repeat=\"task in project.stages\" ui-tree-node=ui-tree-node ng-include=\"'app/states/project/new/stagelist'\"></li></ol></div></div></div><a data-ng-click=submit() href=javascript:void(0) class=\"btn btn-medium btn-primary\">Submit</a><h3>Data binding</h3><div class=row></div><div class=col-sm-6><pre class=code>{{project | json}}</pre></div></div>"
  );


  $templateCache.put('app/states/project/new/stagelist',
    "<div class=tree-node><div ui-tree-handle=ui-tree-handle class=\"pull-left tree-handle\"><span class=\"glyphicon glyphicon-list\"></span></div><div class=tree-node-content><a nodrag=nodrag ng-click=toggle(this) class=\"btn btn-success btn-xs\"><span ng-class=\"{'glyphicon-chevron-right': collapsed, 'glyphicon-chevron-down': !collapsed}\" class=glyphicon></span></a>{{task.title}}<a nodrag=nodrag ng-click=remove(this) class=\"pull-right btn btn-danger btn-xs\"><span class=\"glyphicon glyphicon-remove\"></span><span class=sr-only>Remove</span></a><a nodrag=nodrag ng-click=edit(this) class=\"pull-right btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-pencil\"></span><span class=sr-only>Edit</span></a><a nodrag=nodrag ng-click=newTask(this) style=\"margin-right: 8px\" class=\"pull-right btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-plus\"></span><span class=sr-only>Add</span></a></div><ol ui-tree-nodes=\"\" ng-model=task.tasks ng-class=\"{hidden: collapsed}\"><li ng-repeat=\"task in task.tasks\" ui-tree-node=ui-tree-node ng-include=\"'app/states/project/new/stagelist'\"></li></ol></div>"
  );


  $templateCache.put('app/states/project/project',
    "<h2>Project</h2><div class=\"container project\"><div data-ui-view=projectChildView></div></div>"
  );


  $templateCache.put('app/states/user/details/details',
    "<div class=\"container userDetail\"><h3>detail pages</h3><p>{{user.name}}</p><p>{{user.email}}</p><a data-ng-click=edit() href=javascript:void(0) class=\"btn btn-medium btn-primary\">Edit</a></div>"
  );


  $templateCache.put('app/states/user/form/form',
    "<h2>{{formTitle}}</h2><div class=userForm><form name=userForm><div data-ng-class=\"{'has-error': userForm.name.$invalid &amp;&amp; !userForm.name.$pristine}\" class=form-group><label>User Name</label><input placeholder=\"user name\" name=name required data-ng-model=user.name maxlength={{attributes.name.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.name.$invalid &amp;&amp; !userForm.name.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': userForm.email.$invalid &amp;&amp; !userForm.email.$pristine}\" class=form-group><label>Email</label><input type=email placeholder=\"email address\" name=email required data-ng-model=user.email maxlength={{attributes.email.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.email.$invalid &amp;&amp; !userForm.email.$pristine\" class=error>Enter a valid email.</p></div><div data-ng-class=\"{'has-error': userForm.password.$invalid &amp;&amp; !userForm.password.$pristine}\" class=form-group><label>Password</label><input type=password placeholder=password name=password required data-ng-model=user.password maxlength={{attributes.password.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.password.$invalid &amp;&amp; !userForm.password.$pristine\" class=error>Required.</p></div><div data-ng-class=\"{'has-error': (userForm.confirmPassword.$invalid || userForm.confirmPassword.$error.match) &amp;&amp; !userForm.confirmPassword.$pristine}\" class=form-group><label>Confirm password</label><input type=password placeholder=\"confirm password\" name=confirmPassword required data-ng-model=user.confirmPassword data-field-match={{user.password}} maxlength={{attributes.confirmPassword.maxLength}} class=\"form-control\"><p data-ng-show=\"userForm.confirmPassword.$error.match &amp;&amp; !userForm.confirmPassword.$pristine\" class=error>Password dosen't match</p></div><button type=submit data-ng-click=sumbit() href=javascript:void(0); class=\"btn btn-lg btn-primary btn-block\">{{submitBtnText}}</button></form></div>"
  );


  $templateCache.put('app/states/user/list/list',
    "<div class=\"container userList\"><h3>User List</h3><div class=container><ul><li data-ng-repeat=\"user in users\"><span data-ng-show=user.online>[online]</span><a data-ng-click=show(user) href=javascript:void(0);><span>{{user.name}}</span></a><a data-ng-click=edit(user) href=javascript:void(0);><span>edit</span></a><a data-ng-click=destroy(user) href=javascript:void(0);><span>delete</span></a></li></ul></div></div>"
  );


  $templateCache.put('app/states/user/user',
    "<h2>User</h2><div class=container><div data-ui-view=userChildView></div></div>"
  );


  $templateCache.put('common/navigation/navigation',
    "<ul class=\"nav nav-pills\"><li><a data-ui-sref=user.list>User</a></li><li><a data-ui-sref=project>Project</a></li><li><a data-ui-sref=signup>Signup</a></li><li><a href=JavaScript:void(0); data-ng-click=logout()>Logout</a></li></ul>"
  );


  $templateCache.put('common/pagination/pagination',
    "<ul class=pagination><li data-ng-class=\"{disabled:index == 0 || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=first()>&laquo;</a></li><li data-ng-class=\"{disabled:index == 0 || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=previous()>&lt;</a></li><li data-ng-repeat=\"page in displayPages\" data-ng-class={active:page.current}><a href=JavaScript:void(0); data-ng-click=goPage(page)>{{page.index+1}}</a></li><li data-ng-class=\"{disabled:index &gt;= lastPage.first || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=next()>&gt;</a></li><li data-ng-class=\"{disabled:index &gt;= lastPage.first || displayPages.length == 0}\"><a href=JavaScript:void(0); data-ng-click=last()>&raquo;</a></li></ul>"
  );


  $templateCache.put('common/uitree/template1',
    "<div class=tree-node><div ui-tree-handle=ui-tree-handle class=\"pull-left tree-handle\"><span class=\"glyphicon glyphicon-list\"></span></div><div class=tree-node-content><a nodrag=nodrag ng-click=toggle(this) class=\"btn btn-success btn-xs\"><span ng-class=\"{'glyphicon-chevron-right': collapsed, 'glyphicon-chevron-down': !collapsed}\" class=glyphicon></span></a>{{node.title}}<a nodrag=nodrag ng-click=remove(this) class=\"pull-right btn btn-danger btn-xs\"><span class=\"glyphicon glyphicon-remove\"></span><span class=sr-only>Remove</span></a><a nodrag=nodrag ng-click=edit(this) class=\"pull-right btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-pencil\"></span><span class=sr-only>Edit</span></a><a nodrag=nodrag ng-click=newSubItem(this) style=\"margin-right: 8px\" class=\"pull-right btn btn-primary btn-xs\"><span class=\"glyphicon glyphicon-plus\"></span><span class=sr-only>Add</span></a></div><ol ui-tree-nodes=\"\" ng-model=node.nodes ng-class=\"{hidden: collapsed}\"><li ng-repeat=\"node in node.nodes\" ui-tree-node=ui-tree-node ng-include=\"'common/uitree/template1'\"></li></ol></div>"
  );
} ]);});