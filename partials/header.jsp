<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<nav class="navbar navbar-default bg-black">
    <div class="container-fluid">
        <div class="navbar-header col-xs-1">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
            data-target="#navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <c:if test="${kapp != null}">
                <a class="navbar-brand" href="${bundle.kappLocation}">
                    <c:if test="${not empty kapp.getAttribute('logo-url')}">
                        <img src="${bundle.location}/images/${kapp.getAttribute('logo-url').value}" alt="logo">
                    </c:if>
                    <c:if test="${empty kapp.getAttribute('logo-url')}">
                        <i class="fa fa-home"></i> ${text.escape(kapp.name)}
                    </c:if>
                </a>
            </c:if>
        </div>

        <div class="collapse navbar-collapse" id="navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="hidden-xs dropdown" style="display:none">
                    <a id="drop2" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="hidden-lg hidden-md">Kapps <span class="fa fa-caret-down fa-fw"></span></span><span class="hidden-sm hidden-xs fa fa-th fa-fw"></span></a>
                    <ul class="dropdown-menu" aria-labelledby="drop2">
                        <li class="category">
                            <a class="white color-hover-ice" href="javascript:void(0);" aria-label="My Dashboard">
                                <i class="fa fa-th-large"></i>
                                <span>My Dashboard</span>
                            </a>
                        </li>
                        <c:forEach items="${kapp.categories}" var="category">
                            <%-- If the category is not hidden, and it contains at least 1 form --%>
                            <c:if test="${fn:toLowerCase(category.getAttribute('Hidden').value) ne 'true'}">
                                <li class="category">
                                    <a class="white color-hover-ice" href="${bundle.spaceLocation}/${kapp.slug}?page=categories&category=${category.name}" aria-label="${text.escape(category.name)}">
                                        <i class="fa ${category.getAttribute('fa-logo').value}"></i>
                                        <span>${text.escape(category.name)}</span>
                                    </a>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </li>
                <li class="white color-hover-ice">
                    <a href="${bundle.kappLocation}" role="button">
                        <span class="fa fa-home"></span>
                    </a>
                </li>
                <li class="messages white color-hover-ice">
                    <a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <span class="fa fa-bell"></span>
                    </a>
                    <c:import url="${bundle.path}/partials/alerts.jsp?orient=vertical"/>
                </li>
                <li class="dropdown white">
                    <a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        Hello, 
                        <span class="user-fullname">${text.escape(identity.user.displayName)} </span>
                        <span class="fa fa-chevron-circle-down"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="drop1">
                        <li><a href="${bundle.spaceLocation}/${kapp.slug}?page=profile"><i class="fa fa-pencil fa-fw"></i> Edit Profile</a></li>
                        <li class="divider"></li>
                        <li><a href="${bundle.spaceLocation}/app/"><i class="fa fa-dashboard fa-fw"></i> Management Console</a></li>
                        <li class="divider"></li>
                        <li><a href="${bundle.spaceLocation}/app/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        <c:if test="${kapp != null}">
            <div class="navbar-form" role="search" style='margin-right:1em;'>
                <form action="${bundle.kappLocation}" method="GET" role="form">
                    <div class="form-group">
						<input type="hidden" value="search" name="page">
						<input  type="text" class="states form-control predictiveText x" name="q" placeholder="Search Forms…" autocomplete="off" autofocus="autofocus">
					</div>
                </form>
            </div>
        </c:if>
        </div>
    </div>
</nav>
