﻿/**
********************************************************************************
ContentBox - A Modular Content Platform
Copyright 2012 by Luis Majano and Ortus Solutions, Corp
www.gocontentbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Apache License, Version 2.0

Copyright Since [2012] [Luis Majano and Ortus Solutions,Corp] 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 

http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License.
********************************************************************************
* Manage the system's email templates for admin purposes
*/
component accessors="true" singleton{
	
	// Dependecnies
	property name="moduleSettings"		inject="coldbox:setting:modules";
	property name="log"					inject="logbox:logger:{this}";
	
	// Local properties
	property name="templatesPath" type="string";
	
	EmailTemplateService function init(){
		templatesPath = '';
		return this;
	}
	
	/**
	* onDIComplete
	*/
	function onDIComplete(){
		setTemplatesPath( moduleSettings["contentbox"].path & "/views/email_templates" );
	}
	
	/**
	* Check if template exists
	*/
	boolean function templateExists(required string name){
		return fileExists( getTemplatesPath() & "/#arguments.name#" );
	}

	/**
	* Get template code
	*/
	string function getTemplateCode(required string name){
		var templatePath = getTemplatesPath() & "/#arguments.name#";
		return fileRead( templatePath );
	}
	
	/**
	* Save template code
	*/
	EmailTemplateService function saveTemplateCode(required string name, required string code){
		var templatePath = getTemplatesPath() & "/#arguments.name#";
		fileWrite( templatePath, arguments.code );
		return this;
	}
	
	/**
	* Get installed templates
	*/
	query function getTemplates(){
		var templates = directoryList(getTemplatesPath(),false,"query","*.cfm","name asc");
		return templates;
	}
	
}