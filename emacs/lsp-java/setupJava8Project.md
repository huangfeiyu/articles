
# Table of Contents

1.  [Emacs lsp-java Configure Java 8 Project With jdtls Which Runs Only on Java 11 or Above](#orge437095)
    1.  [Set `lsp-java-java-path` to where to look for Java 11, for instance, add the following to your init.el](#orgc39365c)
    2.  [Set `lsp-java-configuration-runtimes`, for instance, and the following to your init.el](#org38187ef)
    3.  [Reference](#org3d260c0)


<a id="orge437095"></a>

# Emacs lsp-java Configure Java 8 Project With jdtls Which Runs Only on Java 11 or Above

The latest jdtls runs only on Java 11 or above, but many project still use Java 8, the article show you how to configure emacs lsp-java to use Java 8 for your project with the latest jdtls. Two variables will be used `lsp-java-java-path` and `lsp-java-configuration-runtimes`


<a id="orgc39365c"></a>

## Set `lsp-java-java-path` to where to look for Java 11, for instance, add the following to your init.el

    (setq lsp-java-java-path "/usr/bin/java")


<a id="org38187ef"></a>

## Set `lsp-java-configuration-runtimes`, for instance, and the following to your init.el

    (setq lsp-java-configuration-runtimes '[(:name "JavaSE-1.8"
    											   :path "/usr/local/jdk1.8.0_202" :default t) ;; use Java 8 for your project
    									  (:name "JavaSE-11" :path "/usr/lib/jvm/java-11-openjdk-amd64")
    					])

Have a look at `~/.emacs.d/workspace/.metadata/.plugins/org.eclipse.jdt.launching/libraryInfos.xml`. If you updated your local java path and want LSP to use the new version, try removing the ~/.emacs.d/workspace/ directory and relaunch LSP.


<a id="org3d260c0"></a>

## Reference

[lsp-java github home page](https://github.com/emacs-lsp/lsp-java)

