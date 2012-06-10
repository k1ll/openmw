
#include "console.hpp"

#include <algorithm>

#include <components/compiler/exception.hpp>

#include "../mwscript/extensions.hpp"

#include "../mwbase/environment.hpp"

namespace MWGui
{
    class ConsoleInterpreterContext : public MWScript::InterpreterContext
    {
            Console& mConsole;

        public:

            ConsoleInterpreterContext (Console& console, MWWorld::Ptr reference);

            virtual void report (const std::string& message);
    };

    ConsoleInterpreterContext::ConsoleInterpreterContext (Console& console,
        MWWorld::Ptr reference)
    : MWScript::InterpreterContext (
        reference.isEmpty() ? 0 : &reference.getRefData().getLocals(), reference),
      mConsole (console)
    {}

    void ConsoleInterpreterContext::report (const std::string& message)
    {
        mConsole.printOK (message);
    }

    bool Console::compile (const std::string& cmd, Compiler::Output& output)
    {
        try
        {
            ErrorHandler::reset();

            std::istringstream input (cmd + '\n');

            Compiler::Scanner scanner (*this, input, mCompilerContext.getExtensions());

            Compiler::LineParser parser (*this, mCompilerContext, output.getLocals(),
                output.getLiterals(), output.getCode(), true);

            scanner.scan (parser);

            return isGood();
        }
        catch (const Compiler::SourceException&)
        {
            // error has already been reported via error handler
        }
        catch (const std::exception& error)
        {
            printError (std::string ("An exception has been thrown: ") + error.what());
        }

        return false;
    }

    void Console::report (const std::string& message, const Compiler::TokenLoc& loc, Type type)
    {
        std::ostringstream error;
        error << "column " << loc.mColumn << " (" << loc.mLiteral << "):";

        printError (error.str());
        printError ((type==ErrorMessage ? "error: " : "warning: ") + message);
    }

    void Console::report (const std::string& message, Type type)
    {
        printError ((type==ErrorMessage ? "error: " : "warning: ") + message);
    }

    void Console::listNames()
    {
        if (mNames.empty())
        {
            // keywords
            std::istringstream input ("");

            Compiler::Scanner scanner (*this, input, mCompilerContext.getExtensions());

            scanner.listKeywords (mNames);

            // identifier
            const ESMS::ESMStore& store = MWBase::Environment::get().getWorld()->getStore();

            for (ESMS::RecListList::const_iterator iter (store.recLists.begin());
                iter!=store.recLists.end(); ++iter)
            {
                iter->second->listIdentifier (mNames);
            }

            // sort
            std::sort (mNames.begin(), mNames.end());
        }
    }

    Console::Console(int w, int h, const Compiler::Extensions& extensions, int tabCompletionMode)
      : Layout("openmw_console_layout.xml"),
        mCompilerContext (MWScript::CompilerContext::Type_Console),
        mCompletionMode(tabCompletionMode),
        mPagesize(5),
        mCaseSensitive(false)
    {
        setCoord(10,10, w-10, h/2);

        getWidget(command, "edit_Command");
        getWidget(history, "list_History");

        // Set up the command line box
        command->eventEditSelectAccept +=
            newDelegate(this, &Console::acceptCommand);
        command->eventKeyButtonPressed +=
            newDelegate(this, &Console::keyPress);

        // Set up the log window
        history->setOverflowToTheLeft(true);
        history->setEditStatic(true);
        history->setVisibleVScroll(true);

        // compiler
        mCompilerContext.setExtensions (&extensions);
    }

    void Console::enable()
    {
        setVisible(true);

        // Give keyboard focus to the combo box whenever the console is
        // turned on
        MyGUI::InputManager::getInstance().setKeyFocusWidget(command);
    }

    void Console::disable()
    {
        setVisible(false);
        setSelectedObject(MWWorld::Ptr());
        // Remove keyboard focus from the console input whenever the
        // console is turned off
        MyGUI::InputManager::getInstance().setKeyFocusWidget(NULL);
    }

    void Console::setFont(const std::string &fntName)
    {
        history->setFontName(fntName);
        command->setFontName(fntName);
    }

    void Console::clearHistory()
    {
        history->setCaption("");
    }

    void Console::print(const std::string &msg)
    {
        history->addText(msg);
    }

    void Console::printOK(const std::string &msg)
    {
        print("#FF00FF" + msg + "\n");
    }

    void Console::printError(const std::string &msg)
    {
        print("#FF2222" + msg + "\n");
    }

    void Console::keyPress(MyGUI::WidgetPtr _sender,
                  MyGUI::KeyCode key,
                  MyGUI::Char _char)
    {
        if(key == MyGUI::KeyCode::Tab)
        {
            std::vector<std::string> matches;
            std::string current;

            listNames();

            if(mCompletionMode >= 1)
            {
                current=complete(command->getCaption(), matches, mNames);

                command->setCaption(current);
                /* Display completition possibilites when tab is pressed atleast twice (the input stayed the same ). */
                if((mCompletionMode == 2) && (matches.size() > 1) && (command->getCaption() == mLastComplete))
                {
                    bool end=false;
                    /* Only display the current "page". */
                    for(std::vector<std::string>::iterator it=matches.begin()+(mPage*mPagesize);it < matches.begin()+mPagesize+(mPage*mPagesize);it++)
                    {
                        if(it<matches.end()) {
                            printOK(*it);
                        }
                        else {
                            end=true;
                            break;
                        }
                    }
                    if(end) {
                        mPage=0;
                    }
                    else {
                        mPage++;
                    }
                    printOK(std::string("\n"));
                }
                else
                {
                    mPage=0;
                }
                mLastComplete=current;
            }
        }

        if(command_history.empty()) return;

        // Traverse history with up and down arrows
        if(key == MyGUI::KeyCode::ArrowUp)
        {
            // If the user was editing a string, store it for later
            if(current == command_history.end())
                editString = command->getCaption();

            if(current != command_history.begin())
            {
                current--;
                command->setCaption(*current);
            }
        }
        else if(key == MyGUI::KeyCode::ArrowDown)
        {
            if(current != command_history.end())
            {
                current++;

                if(current != command_history.end())
                    command->setCaption(*current);
                else
                    // Restore the edit string
                    command->setCaption(editString);
            }
        }
    }

    void Console::acceptCommand(MyGUI::EditPtr _sender)
    {
        const std::string &cm = command->getCaption();
        if(cm.empty()) return;

        // Add the command to the history, and set the current pointer to
        // the end of the list
        command_history.push_back(cm);
        current = command_history.end();
        editString.clear();

        // Log the command
        print("#FFFFFF> " + cm + "\n");

        Compiler::Locals locals;
        Compiler::Output output (locals);

        if (compile (cm + "\n", output))
        {
            try
            {
                ConsoleInterpreterContext interpreterContext (*this, mPtr);
                Interpreter::Interpreter interpreter;
                MWScript::installOpcodes (interpreter);
                std::vector<Interpreter::Type_Code> code;
                output.getCode (code);
                interpreter.run (&code[0], code.size(), interpreterContext);
            }
            catch (const std::exception& error)
            {
                printError (std::string ("An exception has been thrown: ") + error.what());
            }
        }

        command->setCaption("");
    }

    std::string Console::complete(const std::string input, std::vector<std::string> &matches, const std::vector<std::string> &in_keywords)
    {
        int splitPos;
        std::string output;
        splitPos = getSplitPos(input);
        output = findMatches(input.substr(splitPos), matches, in_keywords);

        //Combine the completed string with the base string and add quotation marks where necessary
        if(matches.size() > 0)
        {
            if(output.find(' ') != std::string::npos)
            {
                if(input[splitPos-1] != '"')
                    output = input.substr(0, splitPos) + '"' + output;
                else
                    output = input.substr(0, splitPos) + output;

                if(matches.size() == 1)
                    output += "\" ";

                return output;
            }
            else
            {
                if(matches.size() == 1)
					return input.substr(0, splitPos) + output + ' ';

                return input.substr(0, splitPos) + output;
            }
        }

        return input;
    }

	//Searches and returns the position which most likely is the start of the string which should be completed

    int Console::getSplitPos(const std::string input)
    {
        int splitPos=0;
        bool openQuote=false;

        for(int i = 0; i < static_cast<int>(input.length()); i++) {
            switch(input[i]) {
            case '"':
                    if(openQuote)
                    {
                        openQuote = false;
                        //std::cout << i << ":Found end quote." << std::endl;
                        splitPos = i+1;
                        continue;
                    }

                    openQuote = true;
                    splitPos = i+1;
            break;

            case '-': //->
                if(input[i+1] == '>')
                {
                    if(openQuote)
                    {
                        //std::cout << i << ":Expected \" but found -> instead." << std::endl;
                        return 0;
                    }

                    splitPos = i+2;
                }
            break;

            case '.':
                    if(openQuote)
                    {
                        //std::cout << i << ":Expected \" but found . instead." << std::endl;
                        return 0;
                    }

                    splitPos = i+1;
            break;

            case ' ':
                    if(openQuote)
                    {
                        //std::cout << i << ":Skipping white space in quotes." << std::endl;
                        continue;
                    }

                    splitPos = i+1;
            break;

            default:
                continue;
            }
        }

        return splitPos;
    }

    //Finds all strings in the vector in_keywords which start with the string input and saves them in the vector matches
    //Returns a string containing the part at the start of all strings in matches which is the same 

    std::string Console::findMatches(const std::string input, std::vector<std::string> &matches, const std::vector<std::string> &in_keywords)
    {
        std::vector<std::string> keywords = in_keywords;

        if(input.length() == 0) {
            matches=keywords;
            return input;
        }

        /* Iterate through the vector. */
        for(std::vector<std::string>::iterator it=keywords.begin(); it < keywords.end();it++) {
            bool stringDifferent=false;

            /* Is the string shorter than the input string? If yes skip it. */
            if((*it).length() < input.length())
                continue;

            /* Is the beginning of the string different from the input string? If yes skip it. */
            for(std::string::const_iterator iter=input.begin(), iter2=(*it).begin(); iter < input.end();iter++, iter2++) {
                if(!compare(*iter,*iter2)) {
                    stringDifferent=true;
                    break;
                }
            }

            if(stringDifferent)
                continue;

            /* The beginning of the string matches the input string, save it for the next test. */
            matches.push_back(*it);
        }

        /* There are no matches. Return the unchanged input. */
        if(matches.empty())
            return input;

        /* Only one match. We're done. */
        if(matches.size() == 1)
            return matches.front();

        /* Check if all matching strings match further than input. If yes complete to this match. */

        int i = input.length();

        for(std::string::iterator iter=matches.front().begin()+input.length(); iter < matches.front().end(); iter++, i++) {
            for(std::vector<std::string>::iterator it=matches.begin(); it < matches.end();it++) {
                if(!compare((*it)[i],*iter)) {
                    /* Return the longest match found */
                    return matches.front().substr(0, i);
                }
            }
        }

        //This should never be called.
        return matches.front();
    }

    bool Console::compare(const char x, const char y)
    {
        if(mCaseSensitive)
            return x == y;
        else
            return tolower(x) == tolower(y);
    }

    void Console::onResChange(int width, int height)
    {
        setCoord(10,10, width-10, height/2);
    }

    void Console::setSelectedObject(const MWWorld::Ptr& object)
    {
        mPtr = object;
        if (!mPtr.isEmpty())
            setTitle("#{sConsoleTitle} (" + mPtr.getCellRef().refID + ")");
        else
            setTitle("#{sConsoleTitle}");
    }

    void Console::onReferenceUnavailable()
    {
        setSelectedObject(MWWorld::Ptr());
    }
}
