﻿/**
 * OWASP Enterprise Security API (ESAPI)
 * 
 * This file is part of the Open Web Application Security Project (OWASP)
 * Enterprise Security API (ESAPI) project. For details, please see
 * <a href="http://www.owasp.org/index.php/ESAPI">http://www.owasp.org/index.php/ESAPI</a>.
 *
 * Copyright (c) 2011 - The OWASP Foundation
 * 
 * The ESAPI is published by OWASP under the BSD license. You should read and accept the
 * LICENSE before you use, modify, and/or redistribute this software.
 * 
 * @author Damon Miller
 * @created 2011
 */
component ValidationErrorListTest extends="cfesapi.test.org.owasp.esapi.lang.TestCase" {

	// imports
	System = createObject("java", "java.lang.System");

	/**
	 * {@inheritDoc}
	 *
	 * @throws Exception
	 */
	
	public void function setUp() {
		instance.ESAPI = new cfesapi.org.owasp.esapi.ESAPI();
	}
	
	/**
	 * {@inheritDoc}
	 *
	 * @throws Exception
	 */
	
	public void function tearDown() {
		instance.ESAPI = "";
	}
	
	public void function testAddError() throws Exception {
		System.out.println("testAddError");
		local.vel = new cfesapi.org.owasp.esapi.ValidationErrorList();
		local.vex = createValidationException();
		local.vel.addError("context", vex);
		try {
			local.vel.addError("", vex);
			fail("");
		}
		catch(any e) {
			// expected
		}
		try {
			local.vel.addError("context1", "");
			fail("");
		}
		catch(any e) {
			// expected
		}
		try {
			local.vel.addError("context", local.vex);// add the same context again
			fail("");
		}
		catch(any e) {
			// expected
		}
	}
	
	public void function testErrors() throws Exception {
		System.out.println("testErrors");
		local.vel = new cfesapi.org.owasp.esapi.ValidationErrorList();
		local.vex = createValidationException();
		local.vel.addError("context", local.vex);
		assertTrue(local.vel.errors().get(0).toString() == local.vex.toString());
	}
	
	public void function testGetError() throws Exception {
		System.out.println("testGetError");
		local.vel = new cfesapi.org.owasp.esapi.ValidationErrorList();
		local.vex = createValidationException();
		local.vel.addError("context", local.vex);
		assertTrue(local.vel.getError("context").toString() == local.vex.toString());
		assertTrue(isNull(local.vel.getError("ridiculous")));
	}
	
	public void function testIsEmpty() throws Exception {
		System.out.println("testIsEmpty");
		local.vel = new cfesapi.org.owasp.esapi.ValidationErrorList();
		assertTrue(local.vel.isEmpty());
		local.vex = createValidationException();
		local.vel.addError("context", local.vex);
		assertFalse(local.vel.isEmpty());
	}
	
	public void function testSize() throws Exception {
		System.out.println("testSize");
		local.vel = new cfesapi.org.owasp.esapi.ValidationErrorList();
		assertTrue(local.vel.size() == 0);
		local.vex = createValidationException();
		local.vel.addError("context", local.vex);
		assertTrue(local.vel.size() == 1);
	}
	
	private cfesapi.org.owasp.esapi.errors.ValidationException function createValidationException() {
		local.vex = "";
		try {
			local.vex = new cfesapi.org.owasp.esapi.errors.ValidationException(instance.ESAPI, "User message", "Log Message");
		}
		catch(cfesapi.org.owasp.esapi.errors.IntrusionException e) {
			// expected occasionally
		}
		return local.vex;
	}
	
}