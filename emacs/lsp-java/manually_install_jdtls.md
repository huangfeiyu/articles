Emacs Lsp-java Manually Install jdtls (Eclipse Java Language Server)
==============
After installing lsp-java from melpa, usually, lsp-java will prompt you to install eclipse java language server when you open a java source code file the first time. Or you can run command `lsp-install-server` then select jdtls to install. Usually, this works fine. However, if you are experiencing network problem, the network connection to raw.githubusercontent.com:443 can not be established, this article is for you. In the following I'll show you how to manually install jdtls for emacs lsp-java.
1. Clone lsp-java git repository.
```
git clone https://github.com/emacs-lsp/lsp-java.git
```
2. cd to the maven directory
```
cd /path-to-lsp-java/lsp-java/install
```
3. Execute the following maven command to finish the installation, you need to setup apache maven first before run the following command
```
mvn -Djdt.js.server.root\=/home/yyoncho/.emacs.d/.cache/lsp/eclipse.jdt.ls/ -Djunit.runner.root\=/home/yyoncho/.emacs.d/eclipse.jdt.ls/test-runner/ -Djunit.runner.fileName\=junit-platform-console-standalone.jar -Djava.debug.root\=/home/yyoncho/.emacs.d/.cache/lsp/eclipse.jdt.ls/bundles clean package -Djdt.download.url\=https\://download.eclipse.org/jdtls/milestones/1.0.0/jdt-language-server-1.0.0-202104151857.tar.gz
```
You can change the `jdt.download.url` to the url which refers to the jdtls version you want, you can find a list of jdtls [HERE](https://projects.eclipse.org/projects/eclipse.jdt.ls "Eclipse JDT Language Server"). The latest jdtls requires Java 11 to run, the last version jdtls which can runs on Java 8 is [0.57.0](https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz)
