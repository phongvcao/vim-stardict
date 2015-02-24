import re
import subprocess


def formatToBashStr(outputStr):
    return formatStr(outputStr)


def formatToVimStr(outputStr):
    return formatStr(outputStr)


def getDefinition(argsList):
    process = subprocess.Popen("\\ ".join(argsList))


def formatStr(outputStr):
    replacedBullet = 1
    replacedStr = ""
    wordMeaningPattern = "^\\-\\s+.*"
    wordExamplePattern = "^\\=.*"
    wordMultiExamplesPattern = "^\\!.*"
    wordPattern = "^\\@.*"
    dictNamePattern = "^\\-\\-\\>.*"
    finalStr = ""

    startLineCharIdx = -1
    prevLineCharIdx = -1
    while True:
        endLineCharIdx = outputStr.find('\n', startLineCharIdx + 1)

        if (endLineCharIdx < 0):
            break

        # Also include newline as part of the extracted string
        line = outputStr[startLineCharIdx + 1:endLineCharIdx + 1]

        # The order of the if/elseif statements matter to the logic flow of
        # this function
        if (re.match(wordExamplePattern, line)):
            # Re-format WordExample
            replacedStr = re.sub("^\\=\\s*", "\\t- ", line,
                    flags=re.IGNORECASE)
            replacedStr = re.sub("^\\+\\s*", ": ", replacedStr,
                    flags=re.IGNORECASE)
            finalStr += replacedStr

        elif (re.match(wordMeaningPattern, line)):
            # Re-format WordMeaning
            if (prevLineCharIdx > -1):
                prevLine = outputStr[prevLineCharIdx + 1:startLineCharIdx + 1]

                if (re.match(wordMultiExamplesPattern, prevLine)):
                    replacedStr = re.sub("^\\-", "\\t\\t-", line,
                            flags=re.IGNORECASE)
                else:
                    replacedStr = re.sub("^\\-\\s+", replacedBullet + ". ",
                            line, flags=re.IGNORECASE)
                    ++replacedBullet
            finalStr += replacedStr

        elif (re.match(wordPattern, line)):
            # Re-format Word
            replacedStr = re.sub("^\\@", "", line, flags=re.IGNORECASE)
            finalStr += replacedStr
            replacedBullet = 1

        prevLineCharIdx = startLineCharIdx
        startLineCharIdx = endLineCharIdx

    replacedBullet = 1
    replacedStr = ""
    startLineCharIdx = -1
    finalStr2 = ""

    while True:
        endLineCharIdx = finalStr.find('\n', startLineCharIdx + 1)

        if (endLineCharIdx < 0):
            break

        # Also include newline as part of the extracted string
        line = finalStr[startLineCharIdx + 1:endLineCharIdx + 1]

        if (re.match(wordMultiExamplesPattern, line)):
            replacedStr = re.sub("^\\!(.*)", "\\t- \\1:", line,
                    flags=re.IGNORECASE)
            finalStr2 += replacedStr

        elif (re.match(dictNamePattern, line)):
            replacedStr = re.sub("^\\-\\-\\>", "@Dictionary: ", line,
                    re.IGNORECASE)
            finalStr2 += replacedStr

            startLineCharIdx = endLineCharIdx
            endLineCharIdx = finalStr.find('\n', startLineCharIdx + 1)
            line = finalStr[startLineCharIdx + 1:endLineCharIdx + 1]

            replacedStr = re.sub("^\\-\\-\\>", "@SearchedTerm: ", line,
                    re.IGNORECASE)
            finalStr2 += replacedStr

        startLineCharIdx = endLineCharIdx

    return finalStr2
