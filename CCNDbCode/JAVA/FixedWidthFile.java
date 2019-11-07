package com.batches;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

public class FixedWidthFile {
	// these can be public because they're immutable
	public final String fileName;
	public final int nLines;

	// need to be private or protected because mutable
	protected List<String> lines = new ArrayList<>();
	protected List<List<String>> tokens;

	// return tokens as immutable List<List<String>>
	public List<List<String>> tokens() {
		List<List<String>> rows = new ArrayList<>(nLines);
		for (List<String> row : tokens)
			rows.add(Collections.unmodifiableList(row));
		return Collections.unmodifiableList(rows);
	}

	// infer column widths
	public FixedWidthFile (String fileName) {
		this(fileName, null);
	}

	// specify column widths with List<Integer>
	public FixedWidthFile (String fileName, List<Integer> columnWidths) {
		this.fileName = fileName; // open the file
		String line = null; // temporary line holder
		try { // catch checked Exceptions, throw unchecked ones
			final BufferedReader reader = new BufferedReader(new FileReader(fileName));// throws FileNotFoundException
			while ((line = reader.readLine()) != null) lines.add(line); // throws IOException
		} catch (FileNotFoundException ex) {
			throw new IllegalArgumentException(String.format("file '%s' not found", fileName));
		} catch (IOException ex) {
			throw new IllegalStateException("IOException encountered");
		}
		this.nLines = lines.size();
		this.tokens = new ArrayList<>(nLines); // parsed lines will be held here
		List<Integer> emptyIndices = null; // column widths
		// if user does not supply column widths, we have to infer them
		if (columnWidths == null || columnWidths.size() < 1) {
			List<List<Boolean>> charsNonWS = new ArrayList<>(); // convert to char array, map to `true` if non-whitespace character
			for (int ll = 0; ll < this.nLines; ++ll) {
				charsNonWS.add(new ArrayList<Boolean>());
				List<Boolean> temp = charsNonWS.get(ll);
				for (char ch : lines.get(ll).toCharArray())
					temp.add(!Character.isWhitespace(ch));
			}
			final int nCharCols = charsNonWS.stream().mapToInt(e -> e.size()).max().orElse(0); // get maximum number of character columns in any row
			int[] counts = new int[nCharCols]; // count number of non-whitespace characters per column
			for (List<Boolean> row : charsNonWS)
				for (int cc = 0; cc < row.size(); ++cc)
					if (row.get(cc))
						++counts[cc];
			// histogram of `counts`
			Map<Integer, Long> map = Arrays.stream(counts).mapToObj(i -> (Integer)i).
					collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
			int emptyColDef = Collections.min(map.keySet()); // find the minimum number of non-whitespace characters in any char column
			List<Boolean> emptyCols = Arrays.stream(counts).
					mapToObj(n -> n == emptyColDef).collect(Collectors.toList()); // find delimiting columns
			emptyIndices = new ArrayList<>(); // instantiate and fill list
			for (int cc = 0; cc < nCharCols; ++cc)
				if (emptyCols.get(cc))
					emptyIndices.add(cc);
			// do this a slightly different way than in the article, get column *widths*
			for (int ii = 1; ii < emptyIndices.size(); ++ii)
				for (int jj = 0; jj < ii; ++jj)
					emptyIndices.set(ii, emptyIndices.get(ii) - emptyIndices.get(jj));
		} else { // if user has supplied column widths, just use that
			emptyIndices = columnWidths;
		}
		final int nDataCols = emptyIndices.size(); // number of data columns
		// parse tokens from lines and column widths
		for (int ll = 0; ll < nLines; ++ll) {
			this.tokens.add(new ArrayList<String>());
			List<String> tokensList = this.tokens.get(ll);
			line = lines.get(ll);
			final int len = line.length();
			// this bit is different than in the article
			int tokenStart = 0;
			int tokenEnd = -1;
			for (int ii = 0; ii < nDataCols; ++ii) {
				tokenEnd = tokenStart + emptyIndices.get(ii);
				if (len < tokenEnd) break;
				tokensList.add(line.substring(tokenStart, tokenEnd).trim());
				tokenStart = tokenEnd;
			}
		}
	} // end of constructor
}
